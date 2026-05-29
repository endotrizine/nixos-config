{ pkgs, ... }:
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

  # было — дополняем extraPortals и добавляем config
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-termfilechooser   # ← добавил
    ];
    config.niri = {
    	default = [ "gnome" "gtk" ];
    	"org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
  	};# ← добавил
  };
	environment.sessionVariables = {
    GDK_DEBUG = "portals";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORMTHEME = "xdgdesktopportal";   # ← для Telegram/Qt
  };

  # конфиг termfilechooser — путь к врапперу подставится из стора
  environment.etc."xdg/xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME
    env=TERMCMD=kitty -T "filechooser"
  '';

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  
	# pohui
	fonts.packages = with pkgs; [ geist-font ];
}
