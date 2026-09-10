# было: home/settings/direnv.nix
{ ... }:
{
  flake.modules.homeManager.common =
    { ... }:
    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        config.global = {
          hide_env_diff = true;
          log_format = "";
        };
      };
    }
  ;
}
