{ pkgs }:
with pkgs; [
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

  # Python

  # frontend

  #  utils
  httpie
	nix-direnv

  # Terminals
  foot
  kitty

  # Editors
	lapce

  # File managers
  kdePackages.dolphin
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

  # Theming
  adw-gtk3
  capitaine-cursors

  # Misc
  libnotify
  libqalculate
  translate-shell
  wlsunset
  clash-verge-rev

	ayugram-desktop

	# Font 
	geist-font

	bibata-cursors
]
