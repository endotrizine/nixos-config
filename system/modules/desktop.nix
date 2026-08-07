{ pkgs, ... }:

let
  spfWrapper = pkgs.writeShellScript "spf-portal-wrapper" ''
    set -e

    multiple="$1"
    directory="$2"
    save="$3"
    path="$4"
    out="$5"

    if [ -z "$path" ] || [ ! -e "$path" ]; then
      path="$HOME"
    fi

    exec ${pkgs.kitty}/bin/kitty --title "termfilechooser" \
      ${pkgs.superfile}/bin/superfile --chooser-file="$out" "$path"
  '';
in
{
  programs.niri.enable = true;

  services.xserver.enable = false;
  services.displayManager.gdm.enable = false;
  services.desktopManager.gnome.enable = false;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = "endotrizine";
    };
  };

  # Порталы
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-termfilechooser
    ];
    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
    };
  };

  environment.sessionVariables = {
    GDK_DEBUG = "portals";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
  };

  environment.etc."xdg/xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${spfWrapper}
    default_dir=$HOME
  '';

  # Создаем папку в ~/.config и линкуем туда конфиг
  systemd.tmpfiles.rules = [
    "d /home/endotrizine/.config/xdg-desktop-portal-termfilechooser 0755 endotrizine users -"
    "L+ /home/endotrizine/.config/xdg-desktop-portal-termfilechooser/config - - - - /etc/xdg/xdg-desktop-portal-termfilechooser/config"
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  fonts.packages = with pkgs; [ geist-font ];
  programs.dconf.enable = true;
}
