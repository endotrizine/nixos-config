# Миграция на реальное железо

Текущая структура поддерживает несколько хостов из одного `flake.nix`. ВМ
живёт в `hosts/vm/`. Чтобы добавить реальный десктоп — заведи `hosts/desktop/`
(имя любое, ниже примеры с `desktop`).

## Шаг 0 — на текущей машине (Arch-хост)

1. Закоммить свежее состояние конфига:

```fish
pushnix     # alias: cd /etc/nixos && git add . && git commit -m 'update' && git push
```

2. Запушь репо куда-нибудь (GitHub/GitLab) — на новой машине будешь клонить.

## Шаг 1 — установка NixOS на железо

1. Загрузись с NixOS minimal/graphical ISO.
2. Разметь диск (для современного железа — GPT + ESP). Включи swap по вкусу.
3. Смонтируй: `/mnt` корень, `/mnt/boot` ESP.
4. Сгенерируй базовый конфиг (нужен только `hardware-configuration.nix`):

```fish
sudo nixos-generate-config --root /mnt
```

5. Склонируй свой репо:

```fish
sudo nix-shell -p git --run "git clone https://github.com/<user>/<repo> /mnt/etc/nixos-tmp"
```

## Шаг 2 — заведи новый host

```fish
cd /mnt/etc/nixos-tmp
mkdir -p hosts/desktop
# hardware-configuration.nix, сгенерированный для железа, кладём сюда:
cp /mnt/etc/nixos/hardware-configuration.nix hosts/desktop/
```

Создай `hosts/desktop/default.nix` (по образцу `hosts/vm/default.nix`):

```nix
{ ... }:
{
  imports = [
    ../../modules
    ./hardware-configuration.nix
    ./boot.nix
    ./nvidia.nix     # если NVIDIA
  ];

  networking.hostName = "desktop";
  system.stateVersion = "25.11";
}
```

`hosts/desktop/boot.nix` — для современного UEFI-десктопа:

```nix
{ ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];  # если NVIDIA
}
```

`hosts/desktop/nvidia.nix` (для проприетарного NVIDIA на RTX 3050):

```nix
{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;                          # legacy proprietary; для open NVK ставь true
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = false;
  };
}
```

## Шаг 3 — зарегистрируй хост в flake

В `flake.nix`, в `nixosConfigurations`, добавь строку:

```nix
nixosConfigurations = {
  nixos   = mkSystem "vm";
  desktop = mkSystem "desktop";    # <-- новый
};
```

## Шаг 4 — установить

```fish
sudo mkdir -p /mnt/etc/nixos
sudo mv /mnt/etc/nixos-tmp/* /mnt/etc/nixos-tmp/.* /mnt/etc/nixos/ 2>/dev/null
sudo nixos-install --flake /mnt/etc/nixos#desktop
```

После reboot — войдёт `greetd` → `niri-session` (как сейчас в VM).

## Шаг 5 — переключение между хостами

```fish
# на VM
sudo nixos-rebuild switch --flake /etc/nixos#nixos

# на десктопе
sudo nixos-rebuild switch --flake /etc/nixos#desktop
```

Поправь алиас `rebuild` в `home/aliases.nix` если хочешь чтобы `rebuild`
автоматически выбирал хост по hostname:

```nix
rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#$(hostname) |& nom";
```

## Что осталось в `hosts/vm/` и не нужно на железе

- `hosts/vm/boot.nix` — `device=/dev/vda` (virtio-blk), `fbcon=map:99`, `video=virtio:off`. Всё это VM-specific, на железе не переноси.
- `hosts/vm/vm.nix` — `spice-vdagentd`, `serial-getty@ttyS0` для `virsh console`. Не нужно.

Общие модули (`modules/*.nix`) — переносимы. Если на железе захочешь
отключить что-то конкретное (например `services.openssh`), либо правь
`modules/services.nix`, либо переопределяй в `hosts/desktop/default.nix`:

```nix
services.openssh.enable = false;   # override общего модуля
```

## Что НЕ надо забыть на железе

- **NVIDIA**: добавить `nvidia.nix` (см. выше). Без него под Wayland-niri
  будет чёрный экран или софт-рендер.
- **Микрокод**: добавь `hardware.cpu.intel.updateMicrocode = true;` или
  `hardware.cpu.amd.updateMicrocode = true;` в `hosts/desktop/default.nix`.
- **Firmware**: `hardware.enableRedistributableFirmware = true;`.
- **Btrfs/LVM/LUKS**: если используешь — `nixos-generate-config` сам
  заполнит `hardware-configuration.nix`. Проверь что включены нужные
  `boot.initrd.availableKernelModules` / `luks.devices`.
- **Сеть Ethernet/Wi-Fi**: NetworkManager уже в общих модулях. Для wpa-eap
  и сложных кейсов настраивай в `hosts/desktop/`.
- **Audio**: pipewire в общих модулях, работает из коробки.

## Сценарий dual-boot с уже установленной системой

Если на десктопе уже стоит другая ОС, монтируй её ESP в тот же `/boot`
куда монтируешь NixOS — `systemd-boot` подхватит. Либо `useOSProber = true`
если останешься на GRUB.
