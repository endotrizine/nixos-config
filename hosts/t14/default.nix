# hosts/t14/default.nix
#
# Все .nix файлы прямо в этой папке (hardware-configuration.nix, boot.nix,
# laptop.nix, modules.nix, packages.nix, ...) подхватываются автоматически.
# Чтобы добавить что-то ещё для t14 — просто положите файл сюда.
#
# Внешние импорты (общие modules/, программы из подпапки programs/)
# перечисляем явно, автоимпорт их не трогает.

{ lib, ... }:
let
  importFromDir = import ../../lib/import-dir.nix { inherit lib; };
in
{
  imports = [
    ../../modules
    ./programs/syncthing.nix
  ] ++ (importFromDir ./.);

  networking.hostName = "t14";
  system.stateVersion = "25.11";

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
}

