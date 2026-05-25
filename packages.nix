{ pkgs, inputs, ... }:

with pkgs; [
  # Core
  niri
  xwayland-satellite
  fish

  # Порталы
  xdg-desktop-portal
  xdg-desktop-portal-gtk
  xdg-desktop-portal-gnome

  # Графика/звук (системный уровень)
  pipewire
  wayland
  libdrm
  mesa

	# browser
	inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

  # Qt6 (нужны системно для Noctalia/Quickshell)
  qt6.qtdeclarative
  qt6.qtbase
  qt6.qtsvg
  qt6.qtwayland
  qt6.qt5compat
  qt6.qtimageformats
  qt6.qtmultimedia
  qt6.qtpositioning
  qt6.qtsensors
  qt6.qttools
  qt6Packages.qt6ct
  kdePackages.kirigami
  kdePackages.kdialog
  kdePackages.syntax-highlighting
  jemalloc
  libxcb

  # Системные утилиты
  coreutils
  glib
  polkit
  xdg-user-dirs
  xdg-utils
  blueman
  fprintd
  geoclue2
  ddcutil
  brightnessctl
  swayidle
  swaylock

  # Quickshell/Noctalia
  quickshell
  noctalia-shell

	starship
  bat
  btop
  eza


]
