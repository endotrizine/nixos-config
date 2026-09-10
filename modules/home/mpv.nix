# было: home/settings/mpv.nix
{ ... }:
{
  flake.modules.homeManager.common =
    { ... }:
    {
      programs.mpv = {
        enable = true;
        config.keep-open = "yes";
      };
    }
  ;
}
