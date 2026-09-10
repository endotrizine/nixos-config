# было: hosts/t14/home/settings/niri/default.nix
#
# Раньше на t14 общая modules/home/niri/ ПОЛНОСТЬЮ подменялась через
# resolveSettings (совпадение по имени файла/папки). В дендритик-паттерне
# для этого есть штатный механизм модульной системы — lib.mkForce:
# common-модуль (modules/home/niri) задаёт значение с обычным приоритетом,
# а этот host-модуль перебивает именно эту опцию более высоким приоритетом.
# Никакой "магии" с сопоставлением имён папок — просто явный mkForce.
{ ... }:
{
  flake.modules.homeManager."hosts/t14" =
    { lib, ... }:
    {
      xdg.configFile."niri/config.kdl".source = lib.mkForce ./config.kdl;
    };
}
