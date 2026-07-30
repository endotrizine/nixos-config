# hosts/desktop/default.nix
#
# Точка входа хоста desktop.
#
# ../../system         — общая системная конфигурация (уже резолвит
#                         hosts/desktop/system/settings/* сама, см. system/default.nix)
# ./system/modules/*    — host-only NixOS-опции (boot, nvidia),
#                         подхватываются автоматически (importFromDir)
# ./hardware-configuration.nix — как есть, отдельно
#
# home-manager настраивается в flake.nix и подключает home/default.nix,
# который сам находит host-override в hosts/desktop/home/settings/* — здесь
# ничего home-специфичного дополнительно импортировать не нужно.

{ lib, ... }:
let
  importFromDir = import ../../lib/import-dir.nix { inherit lib; };
in
{
  imports = [
    ../../system
    ./hardware-configuration.nix
  ] ++ (importFromDir ./system/modules);

  networking.hostName = "desktop";
  system.stateVersion = "25.11";

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
