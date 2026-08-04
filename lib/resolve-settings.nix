# lib/resolve-settings.nix
#
# Для каждой программы (из common ИЛИ host-специфичной settings/-директории)
# проверяет, есть ли одноимённый путь (файл .nix или папка с default.nix)
# в host-специфичной settings/-директории. Если есть — используется ОН
# ВМЕСТО общего (полная замена, а не merge). Если нет — используется общий.
#
# Программа не обязана существовать в common: host-only настройки (нет
# аналога в common, актуально только для одного хоста — например пресеты
# EasyEffects под конкретные наушники ноута) подхватываются тоже, просто
# для них нет общего варианта на других хостах.
#
# Пример 1 (override): home/settings/niri/ + hosts/t14/home/settings/niri/
#   -> на t14 используется hosts/t14/home/settings/niri/, home/settings/niri/ игнорируется
#   -> на desktop (нет override) используется home/settings/niri/
#
# Пример 2 (host-only, без записи в common):
#   hosts/t14/home/settings/easyeffects/ (пресетов под наушники t14, в
#   common аналога нет)
#   -> на t14 используется hosts/t14/home/settings/easyeffects/
#   -> на desktop ничего не импортируется (там этой программы просто нет)
#
# Использование в home/default.nix или system/default.nix:
#
#   let
#     resolveSettings = import ../lib/resolve-settings.nix { inherit lib; };
#   in
#   {
#     imports = resolveSettings {
#       common = ./settings;
#       hostSpecific = ../hosts + "/${host}/home/settings";
#     };
#   }

{ lib }:

{ common, hostSpecific }:
let
  # имя программы из пути: и для файла foo.nix, и для папки foo/
  stripNixSuffix = name: lib.removeSuffix ".nix" name;

  entryNames =
    dir:
    if builtins.pathExists dir then
      lib.unique (
        map stripNixSuffix (
          builtins.attrNames (lib.filterAttrs (name: type: name != "default.nix") (builtins.readDir dir))
        )
      )
    else
      [ ];

  # объединяем имена из common И host-specific: программа не обязана
  # существовать в common, чтобы host-only вариант подхватился
  programNames = lib.unique (entryNames common ++ entryNames hostSpecific);

  resolveOne =
    name:
    let
      hostDir = hostSpecific + "/${name}";
      hostFile = hostSpecific + "/${name}.nix";
      commonDir = common + "/${name}";
      commonFile = common + "/${name}.nix";
    in
    if builtins.pathExists hostDir then
      hostDir
    else if builtins.pathExists hostFile then
      hostFile
    else if builtins.pathExists commonDir then
      commonDir
    else
      commonFile;
in
map resolveOne programNames
