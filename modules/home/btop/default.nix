# было: modules/home/btop/default.nix
{ ... }:
{
  flake.modules.homeManager.common =
    # home/settings/btop/default.nix
    { ... }:
    {
      xdg.configFile."btop/btop.conf".source = ./btop.conf;
    }
  ;
}
