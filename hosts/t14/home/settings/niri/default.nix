# hosts/t14/home/settings/niri/default.nix
#
# Полностью заменяет home/settings/niri/ на хосте t14
# (см. resolveSettings в home/default.nix).

{ ... }:
{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
