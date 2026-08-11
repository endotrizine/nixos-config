# home/settings/mimeapps.nix
#
# Дефолтные приложения по MIME-типам (~/.config/mimeapps.list).
# До этого файла xdg.mimeApps не было вообще — xdg-open/порталы
# открывали что попало (или ничего).
#
# nautilus остаётся установлен (home/packages.nix) как запасной/ручной
# вариант, но дефолт для директорий — yazi, запускаемый через свой
# .desktop (см. ниже).
#
# TUI-программы (yazi, nvim) не имеют собственного .desktop —
# GUI (браузер, nautilus) не умеет их запускать напрямую, поэтому
# каждая обёрнута в kitty через xdg.desktopEntries.
# Внутри yazi (Enter на файле) обёртка не нужна — там используются
# дефолтные openers, без похода через .desktop (см. home/settings/editor.nix).

{ ... }:
{
  xdg.desktopEntries.yazi = {
    name = "Yazi";
    genericName = "File Manager";
    comment = "Blazing fast terminal file manager written in Rust";
    exec = "kitty --title yazi -e yazi %f";
    icon = "utilities-terminal";
    terminal = false; # сам оборачивает себя в kitty
    categories = [
      "System"
      "FileTools"
      "FileManager"
      "ConsoleOnly"
    ];
    mimeType = [ "inode/directory" ];
  };

  xdg.desktopEntries.nvim-gui = {
    name = "Neovim";
    genericName = "Text Editor";
    comment = "Открывает файл в nvim внутри kitty";
    exec = "kitty --title nvim -e nvim %f";
    icon = "nvim";
    terminal = false; # сам оборачивает себя в kitty
    categories = [
      "Utility"
      "TextEditor"
      "ConsoleOnly"
    ];
    mimeType = [
      "text/plain"
      "application/json"
      "application/x-yaml"
      "application/toml"
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "yazi.desktop";

      # text/plain — родитель всей иерархии text/* в shared-mime-info
      # ("All text/* types are subclasses of text/plain" — сама спека).
      # Резолвер MIME при отсутствии default для конкретного подтипа
      # (text/x-python, text/markdown, text/x-shellscript и т.д.)
      # поднимается по этой иерархии и берёт default родителя.
      # Так что один default на text/plain покрывает вообще весь текст —
      # весь список конкретных text/* подтипов ниже не нужен.
      "text/plain" = "nvim-gui.desktop";

      # application/* — формально не под text/*, поэтому наследование
      # не гарантировано (по спеке гарантирован только application/octet-stream).
      # На практике json/yaml/toml обычно тоже помечены как sub-class-of
      # text/plain в базе, но явный override дешевле, чем на это полагаться.
      "application/json" = "nvim-gui.desktop";
      "application/x-yaml" = "nvim-gui.desktop";
      "application/toml" = "nvim-gui.desktop";

      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/bmp" = "imv.desktop";
      "image/tiff" = "imv.desktop";

      "application/pdf" = "org.pwmt.zathura.desktop";

      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "audio/mpeg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/x-wav" = "mpv.desktop";

      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };
}
