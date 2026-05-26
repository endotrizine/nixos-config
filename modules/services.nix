{ ... }:
{
  services.openssh.enable = true;
  services.dbus.enable = true;
  services.upower.enable = true;
  security.polkit.enable = true;

  hardware.bluetooth.enable = true;
}
