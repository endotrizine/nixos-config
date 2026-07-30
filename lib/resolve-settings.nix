# lib/resolve-settings.nix
#
# Для каждой программы в общей settings/-директории проверяет, есть ли
# одноимённый путь (файл .nix или папка с default.nix) в host-специфичной
# settings/-директории. Если есть — используется ОН ВМЕСТО общего
# (полная замена, а не merge). Если нет — используется общий.
#
# Пример: home/settings/niri/ + hosts/t14/home/settings/niri/
#   -> на t14 используется hosts/t14/home/settings/niri/, home/settings/niri/ игнорируется
#   -> на desktop (нет override) используется home/settings/niri/
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

  commonEntries =
    if builtins.pathExists common then builtins.readDir common else { };

  # исключаем default.nix верхнего уровня (если он случайно лежит внутри settings/)
  programNames = lib.unique (
    map stripNixSuffix (
      builtins.attrNames (
        lib.filterAttrs (name: type: name != "default.nix") commonEntries
      )
    )
  );

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
