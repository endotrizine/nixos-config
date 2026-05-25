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

    # Graphics / audio (system level)
    pipewire
    wayland
    libdrm
    mesa

    # Browser (from flake input)
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Qt6 (needed system-wide for Noctalia / Quickshell)
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

    # Shell convenience also wanted system-wide
    starship
    bat
    btop
    eza
    fish
  ];
}
