# Миграция: Arch (хост) → NixOS из конфига

Конфиг уже знает про целевое железо: `hosts/desktop/` содержит boot, nvidia,
mounts. Не хватает только `hardware-configuration.nix` — его сгенерирует
`nixos-generate-config` на install-target.

## Целевое железо (зафиксировано в `hosts/desktop/`)

- **CPU**: AMD Ryzen 5 5500 (Zen 3, **нет iGPU** → NVIDIA = единственная графика)
- **GPU**: NVIDIA RTX 3050 (GA106, Ampere). Драйвер — проприетарный stable.
- **RAM**: 46 GiB
- **Boot**: UEFI
- **Сеть**: Realtek RTL8111 Ethernet (в ядре, работает из коробки). Wi-Fi нет.
- **Bluetooth**: нет (модуль в конфиге безвреден на холостом ходу).
- **Диски** (lsblk на момент аудита):
  - `nvme0n1` 931G — основной (1G EFI + 930G btrfs `@/@home/@.snapshots/@pkg/@log`)
  - `sda` 223G ext4 → данные `/mnt/storage2` (UUID `e5554191-54f4-475e-b66b-2a5f8eb304e6`)
  - `sdb` 465G — **Windows 11** (ESP + MSR + NTFS system + NTFS recovery) — **не трогать**
  - `sdc` 931G ntfs → данные `/mnt/storage1` (UUID `6854BD5954BD2B28`)

## Шаг 0 — ПЕРЕД сносом Arch (СДЕЛАЙ ЭТО)

1. Запушь конфиг:
   ```fish
   pushnix
   ```
2. Бэкап:
   - `~/.ssh/` (ключи)
   - `~/.gnupg/` (PGP)
   - Закладки/пароли браузеров (Zen)
   - Список manually-installed пакетов pacman: `pacman -Qqe > ~/Документы/arch-pkgs.txt`
   - Содержимое `/etc/libvirt/qemu/*.xml` (определения ВМ)
3. Подготовь NixOS ISO на флешку: <https://nixos.org/download> (graphical recommended)
4. Проверь что у тебя есть пароль от Wi-Fi / интернета на телефоне (если что — будешь гуглить с него)

## Шаг 1 — boot с NixOS ISO, разметка

**КРИТИЧНО**: трогать только `/dev/nvme0n1`. НЕ форматировать `/dev/sda`, `/dev/sdc`. Особенно НЕ ТРОГАТЬ `/dev/sdb` (Windows).

```fish
sudo -i

# Wipe Arch's nvme0n1 and recreate partitions
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 1025MiB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart NIXROOT 1025MiB 100%

mkfs.fat -F 32 -n boot /dev/nvme0n1p1
mkfs.btrfs -L nixos /dev/nvme0n1p2

# Create subvolumes (mirroring Arch layout — minus pacman cruft)
mount /dev/nvme0n1p2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@log
umount /mnt

# Mount with sane options for SSD btrfs
mount -o noatime,compress=zstd,subvol=@ /dev/nvme0n1p2 /mnt
mkdir -p /mnt/{boot,home,nix,var/log}
mount -o noatime,compress=zstd,subvol=@home /dev/nvme0n1p2 /mnt/home
mount -o noatime,compress=zstd,subvol=@nix  /dev/nvme0n1p2 /mnt/nix
mount -o noatime,compress=zstd,subvol=@log  /dev/nvme0n1p2 /mnt/var/log
mount /dev/nvme0n1p1 /mnt/boot
```

> **ВНИМАНИЕ ESP**: `mkfs.fat` форматирует только `nvme0n1p1` (Arch ESP). Windows ESP — это **отдельный** раздел `sdb1` (UUID `B2B5-674A`), не трогается.
>
> **НО**: systemd-boot сканирует только тот ESP, который смонтирован в `/boot` (=`nvme0n1p1`). Windows на `sdb1` **в systemd-boot menu НЕ появится** — это нормально. Чтобы загрузиться в Windows: при старте жми UEFI boot menu (обычно **F12 / F11 / F8 / Esc** в зависимости от мат. платы) и выбирай `Windows Boot Manager`. NixOS останется default'ом.

## Шаг 2 — установка

```fish
# Generate hardware-configuration.nix
nixos-generate-config --root /mnt

# Clone your config
nix-shell -p git --run "git clone https://github.com/endotrizine/nixos-config /mnt/etc/nixos"

# CRITICAL: replace placeholder hardware-config with the generated one
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/desktop/hardware-configuration.nix

# Sanity check: should see real /dev/disk/by-uuid/... entries, not PLACEHOLDER
cat /mnt/etc/nixos/hosts/desktop/hardware-configuration.nix | head -20

# Install (uses hosts/desktop/, builds NVIDIA module, microcode, all of it)
# WARNING: NVIDIA kernel module compile + package downloads may take 30–60 minutes.
# It's not stuck — watch progress with `htop` in another TTY (Alt+F2).
nixos-install --flake /mnt/etc/nixos#desktop

# At the end nixos-install asks for the root password — set something you remember.
# The endotrizine user gets initialPassword="endotrizine" — CHANGE IT on first login.

reboot
```

## Шаг 3 — первый boot

1. systemd-boot menu появится с одним пунктом `NixOS`. Выбирай. Windows в этом меню НЕТ (см. предупреждение в шаге 1) — для Windows: ребут → UEFI boot menu (F-key).
2. После boot: greetd → niri-session запустится автоматически как `endotrizine`.
3. Если **чёрный экран** при загрузке niri — переключись на TTY (`Ctrl+Alt+F2`), залогинься как root (пароль из шага 2), и:
   ```fish
   journalctl -u greetd -b | tail -50
   nvidia-smi
   modprobe nvidia_drm modeset=1
   ```
4. Если всё хорошо — открой kitty (есть в `home.packages`) и **смени пароль**:
   ```fish
   passwd
   ```

## Шаг 4 — восстановление

- SSH ключи: `cp -r /flash/.ssh ~/`
- gh auth: `gh auth login`
- git remote уже настроен в склоненом репо
- Содержимое ВМ: если qcow2 был на `/mnt/storage1` или `/mnt/storage2`, после монтирования дисков (которые работают через `hosts/desktop/mounts.nix`) — просто переподними libvirt:
  ```fish
  sudo cp /flash/backup/qemu/*.xml /etc/libvirt/qemu/
  sudo virsh -c qemu:///system define /etc/libvirt/qemu/<vm>.xml
  ```
  Но для этого нужен `virtualisation.libvirtd.enable = true` — в текущем общем модуле его НЕТ. Добавишь после первого успешного boot, или сразу в `hosts/desktop/`.

## Что не переносится из `hosts/vm/`

VM-специфика (`fbcon=map:99`, `video=virtio:off`, grub `/dev/vda`, spice-vdagentd, serial-getty) живёт только в `hosts/vm/`. На железе никогда не активируется — она в `hosts/vm/`, а `desktop` импортирует только `modules/` + `hosts/desktop/*`.

## Если что-то совсем плохо

NixOS ISO остаётся загрузочным — boot с него, mount всё как в шаге 1, `nixos-enter --root /mnt` → у тебя shell в установленной системе, можно править `/etc/nixos/...` и `nixos-rebuild boot --flake /etc/nixos#desktop`.

## Чек-лист "не упади в говно"

- [ ] Конфиг запушен (`pushnix`)
- [ ] `~/.ssh`, `~/.gnupg`, browser data забэкаплены **вне** nvme0n1
- [ ] Список pacman -Qqe сохранён
- [ ] NixOS ISO записан и проверен (boot с него хоть до menu)
- [ ] Знаешь UUID Windows ESP (`B2B5-674A` для sdb1) — на случай восстановления Windows boot
- [ ] `hosts/desktop/hardware-configuration.nix` будет **заменён** сгенерированным перед install (placeholder сам по себе НЕ сработает)
- [ ] После reboot **сразу** делаешь `passwd` (меняешь `initialPassword`)
