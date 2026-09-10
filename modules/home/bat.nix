# было: home/settings/bat.nix
{ ... }:
{
  flake.modules.homeManager.common =
    { ... }:
    {
      programs.bat = {
        enable = true;
        config = {
          paging = "never";
        };
      };
    }
  ;
}
