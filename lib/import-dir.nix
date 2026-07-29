# lib/import-dir.nix
#
# Автоматически собирает список путей ко всем .nix файлам в указанной
# директории (кроме default.nix, чтобы не импортировать самого себя).
#
# Использование в любом default.nix:
#
#   let
#     importFromDir = import <путь-до-lib>/import-dir.nix { inherit lib; };
#   in
#   {
#     imports = importFromDir ./programs;
#   }
#
# После этого достаточно положить новый файл в папку — он подхватится
# сам, без правки default.nix.

{ lib }:

dir:
let
  files = builtins.readDir dir;
  nixFiles = lib.filterAttrs
    (name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix")
    files;
in
map (name: dir + "/${name}") (builtins.attrNames nixFiles)
