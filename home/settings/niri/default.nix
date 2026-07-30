# home/settings/niri/default.nix
#
# Общий (desktop) конфиг niri. На t14 эта папка целиком заменяется
# на hosts/t14/home/settings/niri/ — см. resolveSettings в home/default.nix.

{ ... }:
{
	xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
