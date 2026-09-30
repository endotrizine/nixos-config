{ ... }:
{
  flake.modules.homeManager.common =
    { pkgs, ... }:
    {
      programs.qutebrowser.enable = true;
      catppuccin.qutebrowser = {
        enable = true;
        flavor = "mocha";
      };
    };
}
