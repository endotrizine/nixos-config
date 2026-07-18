{ host, ... }:
{
	xdg.configFile."niri/config.kdl".source =
	if host == "t14"
	then ./../../hosts/t14/configs/niri-t14.kdl
	else ./../../hosts/desktop/configs/niri-desktop.kdl;
}
