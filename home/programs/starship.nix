{ pkgs, ... }:
{
  programs.fish.interactiveShellInit = ''
    ${pkgs.starship}/bin/starship init fish | source
  '';

  xdg.configFile."starship.toml".source = ../../configs/starship.toml;
}
