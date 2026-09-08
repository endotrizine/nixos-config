# home/settings/neovim/default.nix
{ ... }:
{
  programs.lazyvim.enable = true;
  #  xdg.configFile = {
  #    "nvim/init.lua".source = ./nvim.lua;
  #    "nvim/lua" = {
  #      source = ./lua;
  #      recursive = true;
  #    };
  #  };
}
