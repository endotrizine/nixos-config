# home/settings/editor.nix
#
# EDITOR/VISUAL = nvim. Это подхватывают: superfile (внутренний 'e'/Enter
# на текстовом файле — без похода через .desktop/kitty, т.к. superfile
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
