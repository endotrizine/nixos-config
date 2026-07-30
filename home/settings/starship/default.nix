# home/settings/starship/default.nix
{ pkgs, ... }:
{
  programs.fish.interactiveShellInit = ''
    ${pkgs.starship}/bin/starship init fish | source
  '';

  xdg.configFile."starship.toml".source = ./starship.toml;
}
