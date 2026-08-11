{ ... }:
{
  xdg.configFile."autostart/koala-clash.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=koala-clash
    Exec=koala-clash
    Icon=koala-clash
    Terminal=false
    Categories=Network;
    X-GNOME-Autostart-enabled=true
  '';
}
