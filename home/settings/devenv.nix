{ config, pkgs, ... }:

{
  xdg.configFile."devenv/config.yaml".text = ''
    version: 1
    shell:
      prompt_prefix: false
  '';
}
