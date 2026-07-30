# home/packages.nix
#
# Юзерские CLI-тулзы и приложения (home-manager, home.packages).
# Одинаковый список на всех хостах (desktop и t14).
# Системные/демон-пакеты — в modules/packages.nix
# Пакеты только для одного хоста — в hosts/<host>/packages.nix

{ pkgs, inputs, ... }:
let
  # Кастомный bottles: пересобираем FHS-окружение без openldap
  # (штатный openldap падает на doCheck в этой связке).
  myBottles = pkgs.bottles.override {
    extraPkgs = pkgs: [ ];
    buildFHSEnv =
      args:
      pkgs.buildFHSEnv (
        args
        // {
          multiPkgs =
            envPkgs:
            let
              originalPkgs = args.multiPkgs envPkgs;
              customLdap = envPkgs.openldap.overrideAttrs (_: {
                doCheck = false;
              });
            in
            builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
        }
      );
  };
in
with pkgs;
[
  # Shell
  bat
  bc
  btop
  curl
  eza
  fd
  file
  fzf
  gum
  jq
  ripgrep
  rsync
  socat
  starship
  tree-sitter
  wget
  zoxide

  # Dev
  git
  gh
  lazygit
  neovim
  nixd
  nixfmt
  nix-output-monitor
  python3
  tealdeer
  zed-editor

  # Utils
  httpie
  nix-direnv
  qbittorrent

  # Terminals
  kitty

  # File managers
  nautilus
  yazi

  # Media
  cava
  easyeffects
  ffmpeg
  ffmpegthumbnailer
  imagemagick
  libdbusmenu-gtk3
  mediainfo
  mpv
  pavucontrol
  playerctl
  yt-dlp
  alsa-utils

  # Archives / files
  p7zip
  poppler
  unzip

  # Screenshots / recording
  grim
  slurp
  swappy
  tesseract
  wf-recorder

  # Clipboard
  cliphist
  wl-clipboard

  # Wayland input
  wtype
  ydotool

  # Launcher
  fuzzel

  # Theming / fonts
  adw-gtk3
  capitaine-cursors
  bibata-cursors
  geist-font

  # Apps
  bitwarden-desktop
  superfile
  obsidian
  onlyoffice-desktopeditors
  pandoc
  #clash-verge-rev
  ayugram-desktop
  myBottles
  flclashx

  # Misc
  libnotify
  libqalculate
  translate-shell
  wlsunset
]
