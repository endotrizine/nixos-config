# system/default.nix
#
# Точка входа системной (NixOS) конфигурации, общей для всех хостов.
#
# system/modules/   — NixOS-опции по функции (audio, networking, ...).
#                      Новый файл подхватывается сам (importFromDir).
# system/packages.nix — системные пакеты, общие для всех хостов.
# system/settings/  — конфиги системных сервисов/программ с raw-файлами.
#                      Если у hosts/<host>/system/settings/<name>/ есть
#                      одноимённая папка/файл — она ПОЛНОСТЬЮ заменяет
#                      общую (host-override), иначе используется общая.
#
# host-специфика (boot.nix, hardware-configuration.nix, host-only модули
# и host-only пакеты) лежит в hosts/<host>/system/ и импортируется из
# hosts/<host>/default.nix, не отсюда.

{ lib, host, ... }:
let
  importFromDir = import ../lib/import-dir.nix { inherit lib; };
  resolveSettings = import ../lib/resolve-settings.nix { inherit lib; };
in
{
  imports =
    [ ./packages.nix ]
    ++ (importFromDir ./modules)
    ++ (resolveSettings {
      common = ./settings;
      hostSpecific = ../hosts + "/${host}/system/settings";
    });
}

