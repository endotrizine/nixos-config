# modules/default.nix
#
# Автоматически импортирует все .nix файлы из этой же директории.
# Чтобы добавить новый модуль — просто положите файл сюда,
# ничего дописывать здесь не нужно.

{ lib, ... }:
let
  importFromDir = import ../lib/import-dir.nix { inherit lib; };
in
{
  imports = importFromDir ./.;
}

