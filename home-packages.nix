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
  neovim
  nixd
  nixfmt-rfc-style
  nodejs
  ollama
  python3
  python3Packages.evdev
  python3Packages.pillow
  zed-editor
	lazygit
  gh
  nix-output-monitor
  tealdeer

  # Python
  uv
  ruff
  pyright

  # Frontend
  pnpm

  # Dev утилиты
  httpie
  gh
  lazygit

  # Терминалы
  foot
  kitty

  # Браузеры

  # Редакторы/IDE
  lapce

  # Файловые менеджеры
  kdePackages.dolphin
  nautilus
  yazi

  # Медиа
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

  # Архивы / файлы
  p7zip
  poppler

  # Скриншоты/запись
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

  # Лаунчер
  fuzzel

  # Theming
  adw-gtk3
  capitaine-cursors

  # Утилиты
  libnotify
  libqalculate
  translate-shell
  wlsunset

  # Прочее
  cloudflare-warp
]
