# было: hosts/t14/default.nix
#
# Базовые атрибуты хоста t14. Остальное (hardware-configuration, boot,
# laptop, nh, packages, syncthing, home-packages, easyeffects, niri) —
# в соседних файлах этой же папки, они мержатся сюда же по имени
# "hosts/t14" (см. modules/wiring/hosts.nix).
{ ... }:
{
  flake.modules.nixos."hosts/t14" = {
    networking.hostName = "t14";
    system.stateVersion = "25.11";

    hardware.cpu.amd.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;
    hardware.bluetooth.enable = true;
  };
}
