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
  bun
  deno
  git
  gh
  lazygit
  neovim
  nixd
  nixfmt
  nix-output-monitor
  nodejs
  ollama
  python3
  python3Packages.evdev
  python3Packages.pillow
  tealdeer
  zed-editor

  # Python
  uv
  ruff
  pyright

  # frontend
  pnpm

  #  utils
  httpie

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

	discord
	equicord
	ayugram-desktop

	# Font 
	geist-font

	bibata-cursors
]
