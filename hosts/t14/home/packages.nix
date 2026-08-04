# hosts/t14/home/packages.nix
#
# Юзерские (home-manager) пакеты только для t14, не устанавливаются
# на desktop. Общие для всех хостов пакеты — в home/packages.nix
#
# Формат такой же как у home/packages.nix: функция, возвращающая список.

{ pkgs, inputs, ... }:
with pkgs;
[
  prismlauncher
]
