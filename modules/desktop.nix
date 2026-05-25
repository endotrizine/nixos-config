{ pkgs, ... }:
{
  # niri (Wayland compositor) — package + helper bits provided by NixOS module
  programs.niri.enable = true;

  # No X11 / GDM / GNOME — niri is the session
  services.xserver.enable = false;
  services.displayManager.gdm.enable = false;
  services.desktopManager.gnome.enable = false;

  # greetd: auto-login endotrizine, auto-start niri-session on seat0
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = "endotrizine";
    };
  };

  # Wayland portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Keyring + PAM integration
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
}
