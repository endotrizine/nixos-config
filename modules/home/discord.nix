# было: home/settings/discord.nix
{ ... }:
{
  flake.modules.homeManager.common =
    { ... }:
    {
      programs.nixcord = {
        enable = true;
        discord.equicord.enable = true;
    		discord.vencord.enable = false;
      };
    }
  ;
}
