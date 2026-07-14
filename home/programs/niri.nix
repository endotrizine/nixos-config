{ host, ... }:
{
	xdg.configFile."niri/config.kdl".source =
	if host == "t14"
	then ./../../configs/niri-t14.kdl
	else ./../../configs/niri-desktop.kdl;
}
