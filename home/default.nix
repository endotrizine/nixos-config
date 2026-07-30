# home/default.nix
#
# Настройки пользователя (home-manager). Одинаковые на всех хостах.
# Специфичные для конкретной машины пакеты/настройки — в hosts/<host>/

{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  # путь до lib/ считаем от корня репозитория: home/ -> ../lib
  importFromDir = import ../lib/import-dir.nix { inherit lib; };
in
{
  imports = [
    inputs.nixcord.homeModules.nixcord
    ./theme.nix
  ]
  ++ (importFromDir ./programs);
  # ^ любой новый файл в home/programs/ подхватится сам,
  #   ничего дописывать сюда не нужно

  home.username = "endotrizine";
  home.homeDirectory = "/home/endotrizine";
  home.stateVersion = "25.11";

  # Список юзерских CLI-тулз и приложений, одинаковый на всех хостах.
  # Системные/демон-пакеты (portals, wayland, qt runtime и т.п.) — в modules/packages.nix
  # Специфичное для одной машины (steam, prismlauncher) — в hosts/<host>/packages.nix
  home.packages = import ./packages.nix { inherit pkgs inputs; };
  programs.home-manager.enable = true;
}
