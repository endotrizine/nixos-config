# было: system/modules/services.nix
{ ... }:
{
  flake.modules.nixos.common =
    { ... }:
    {
      services.openssh.enable = true;
      services.dbus.enable = true;
      services.upower.enable = true;
      security.polkit.enable = true;

      hardware.bluetooth.enable = true;
    }
  ;
}
