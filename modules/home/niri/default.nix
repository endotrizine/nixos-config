# было: home/settings/niri/default.nix
#
# Общий (desktop) конфиг niri. На t14 переопределяется через lib.mkForce
# в modules/hosts/t14/niri/default.nix (host-специфичный override).
{ ... }:
{
  flake.modules.homeManager.common =
    { ... }:
    {
    	xdg.configFile."niri/config.kdl".source = ./config.kdl;
    }
  ;
}
