# hosts/t14/default.nix
#
# Точка входа хоста t14.
#
# ../../system         — общая системная конфигурация (уже резолвит
#                         hosts/t14/system/settings/* сама, см. system/default.nix)
# ./system/modules/*    — host-only NixOS-опции (boot, laptop power, nh),
#                         подхватываются автоматически (importFromDir)
# ./system/packages.nix — host-only системные пакеты (steam, prismlauncher)
# ./hardware-configuration.nix — как есть, отдельно
#
# home-manager настраивается в flake.nix и подключает home/default.nix,
# который сам находит host-override в hosts/t14/home/settings/* — здесь
# ничего home-специфичного дополнительно импортировать не нужно.

{ lib, ... }:
let
  importFromDir = import ../../lib/import-dir.nix { inherit lib; };
in
{
  imports = [
    ../../system
    ./hardware-configuration.nix
    ./system/packages.nix
  ] ++ (importFromDir ./system/modules);

  networking.hostName = "t14";
  system.stateVersion = "25.11";

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
}
