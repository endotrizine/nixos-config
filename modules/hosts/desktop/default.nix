# было: hosts/desktop/default.nix
#
# Базовые атрибуты хоста desktop. Остальное (hardware-configuration,
# boot, nvidia) — в соседних файлах этой же папки, они мержатся сюда же
# по имени "hosts/desktop" (см. modules/wiring/hosts.nix).
{ ... }:
{
  flake.modules.nixos."hosts/desktop" = {
    networking.hostName = "desktop";
    system.stateVersion = "25.11";

    hardware.cpu.amd.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;
  };

  # У desktop пока нет host-only home-manager настроек — но имя должно
  # существовать явно, иначе modules/wiring/hosts.nix не сможет на него
  # сослаться (flake.modules.homeManager не имеет значения по умолчанию
  # для не заданных ключей).
  flake.modules.homeManager."hosts/desktop" = { };
}
