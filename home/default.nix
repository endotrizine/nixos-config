# home/default.nix
#
# Настройки пользователя (home-manager), общие для всех хостов.
#
# home/packages.nix — юзерские пакеты, общие для всех хостов (что стоит).
# home/settings/     — конфиги программ (как настроено), не пакеты.
#                       Новая программа подхватывается сама (importFromDir
#                       для плоских .nix-файлов + resolveSettings для папок
#                       с raw-конфигом).
#                       Если у hosts/<host>/home/settings/<name>/ есть
#                       одноимённая папка/файл — она ПОЛНОСТЬЮ заменяет
#                       общую (host-override), иначе используется общая.
#
# host-специфика (host-only пакеты, host-only настройки) лежит в
# hosts/<host>/home/ и резолвится отсюда же — ничего дополнительно
# подключать в hosts/<host>/default.nix не нужно.

{
  config,
  pkgs,
  lib,
  inputs,
  host,
  ...
}:
let
  importFromDir = import ../lib/import-dir.nix { inherit lib; };
  resolveSettings = import ../lib/resolve-settings.nix { inherit lib; };
in
{
  imports = [
    inputs.nixcord.homeModules.nixcord
    ./theme.nix
  ] ++ (resolveSettings {
    common = ./settings;
    hostSpecific = ../hosts + "/${host}/home/settings";
  });

  home.username = "endotrizine";
  home.homeDirectory = "/home/endotrizine";
  home.stateVersion = "25.11";

  # Список юзерских CLI-тулз и приложений, одинаковый на всех хостах.
  # Системные/демон-пакеты — в system/packages.nix
  # Специфичное для одной машины (host-only пакеты) — в hosts/<host>/home/packages.nix
  home.packages =
    (import ./packages.nix { inherit pkgs inputs; })
    ++ (
      let
        hostPackagesFile = ../hosts + "/${host}/home/packages.nix";
      in
      if builtins.pathExists hostPackagesFile
      then import hostPackagesFile { inherit pkgs inputs; }
      else [ ]
    );

  programs.home-manager.enable = true;
}
