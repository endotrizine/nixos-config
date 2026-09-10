# было: system/settings/koala-clash/default.nix
{ ... }:
{
  flake.modules.nixos.common =
    { pkgs, ... }:

    {
      programs.koala-clash.enable = true;
    }
  ;
}
