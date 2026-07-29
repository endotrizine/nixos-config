# modules/packages.nix
#
# Системные пакеты, нужные любой машине независимо от того, кто в неё
# залогинен: демоны, драйверы, portals, Wayland/Qt рантайм.
#
# Юзерские CLI-тулзы и приложения (git, neovim, btop, starship...) —
# в home/packages.nix, не здесь.
# Пакеты только для одного конкретного хоста — в hosts/<host>/packages.nix

{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # niri / Wayland
    niri
    xwayland-satellite
    # Portals
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    # Graphics / audio
    pipewire
    wayland
    libdrm
    mesa
    pulseaudio
    pulseaudio-ctl
    # Browser
    firefox
    # Qt6
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
    # System utils
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
    # Quickshell / Noctalia
    quickshell
    noctalia-shell
    # VM guest utils (idk, оставлено с wiki)
    dnsmasq
    spice-vdagent
    dconf
  ];
}
