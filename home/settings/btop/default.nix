# home/settings/btop/default.nix
{ ... }:
{
  xdg.configFile."btop/btop.conf".source = ./btop.conf;
}
