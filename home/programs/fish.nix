{ ... }:
let
  aliases = import ../aliases.nix;
in
{
  programs.fish = {
    enable = true;
    shellAliases = aliases;
    shellInit = "set fish_greeting";
  };
	programs.fish.functions.y = ''
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
  '';
  programs.fish.interactiveShellInit = ''
    bind \ej history-search-forward
    bind \ek history-search-backward
    bind \eh backward-char
    bind \el forward-char
  '';
}
