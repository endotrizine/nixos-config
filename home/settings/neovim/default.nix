# home/settings/neovim/default.nix
{ ... }:
{
  xdg.configFile."nvim/init.lua".source = ./nvim.lua;
}
