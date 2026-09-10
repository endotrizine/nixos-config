# было: home/settings/devenv.nix
{ ... }:
{
  flake.modules.homeManager.common =
    { config, pkgs, ... }:

    {
      xdg.configFile."devenv/config.yaml".text = ''
        version: 1
        shell:
          prompt_prefix: false
      '';
    }
  ;
}
