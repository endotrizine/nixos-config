# home/settings/editor.nix
#
# EDITOR/VISUAL = nvim. Это подхватывают: yazi (открытие файла через
# дефолтные openers — без похода через .desktop/kitty, т.к. yazi
# уже сам в терминале), git commit, fzf --preview-edit, tealdeer и т.п.
#
# GUI-путь (браузер, nautilus, xdg-open) отдельно описан в mimeapps.nix
# через xdg.desktopEntries.nvim-gui — там TUI нужно оборачивать в kitty.

{ ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
