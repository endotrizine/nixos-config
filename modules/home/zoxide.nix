# было: home/settings/zoxide.nix
{ ... }:
{
  flake.modules.homeManager.common =
    { ... }:
    {
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
    }
  ;
}
