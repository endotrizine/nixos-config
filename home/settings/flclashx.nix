# home/settings/flclashx.nix
#
# HM-часть FlClashX: автозапуск. Системная часть (security.wrappers,
# нужны root/capabilities) — в system/settings/flclashx/

{ ... }:
{
  xdg.configFile."autostart/flclashx.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=FlClashX
    Exec=FlClashX --minimized
    Icon=FlClashX
    Terminal=false
    Categories=Network;
    X-GNOME-Autostart-enabled=true
  '';
}
