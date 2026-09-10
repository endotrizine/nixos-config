# было: system/modules/kernel.nix
{ ... }:
{
  flake.modules.nixos.common =
    { pkgs, ... }:
    {
    	boot.kernelPackages = pkgs.linuxPackages_6_6;
    }
  ;
}
