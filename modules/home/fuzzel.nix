# было: home/settings/fuzzel.nix
{ ... }:
{
  flake.modules.homeManager.common =
    { ... }:
    {
      programs.fuzzel = {
        enable = true;
      };
    }
  ;
}
