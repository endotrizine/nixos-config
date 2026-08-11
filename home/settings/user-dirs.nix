# home/settings/user-dirs.nix
#
# XDG user-dirs (~/Downloads, ~/Documents и т.д.) — жёстко на английском,
# независимо от системной локали (ru_RU.UTF-8, см. system/modules/locale.nix).
#
# Без этого модуля xdg-user-dirs-update при первом входе в сессию
# локализует папки по локали (Загрузки, Документы, Изображения...).
# home-manager генерирует ~/.config/user-dirs.dirs и ~/.config/user-dirs.locale
# сам — второй файл как раз и не даёт xdg-user-dirs-update потом
# переименовать всё обратно на русский.
#
# ВАЖНО: это не переименовывает уже существующие папки на диске.
# Если ~/Загрузки, ~/Документы и т.п. уже созданы и в них есть файлы —
# нужно перенести руками после rebuild, например:
#   mv ~/Загрузки/* ~/Downloads/ 2>/dev/null; rmdir ~/Загрузки
#   mv ~/Документы/* ~/Documents/ 2>/dev/null; rmdir ~/Документы
# (и так для остальных — Изображения, Видео, Музыка, Рабочий стол, Общедоступные, Шаблоны)

{ config, ... }:
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    publicShare = "${config.home.homeDirectory}/Public";
    templates = "${config.home.homeDirectory}/Templates";
    videos = "${config.home.homeDirectory}/Videos";
  };
}
