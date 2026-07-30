{ ... }:
{
  programs.nixcord = {
    enable = true;
    discord.equicord.enable = true;
		discord.vencord.enable = false;
  };
}
