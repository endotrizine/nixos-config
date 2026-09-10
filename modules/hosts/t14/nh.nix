# было: hosts/t14/system/modules/nh.nix
{ ... }:
{
  flake.modules.nixos."hosts/t14" =
    { ... }:
    {
    	programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/etc/nixos"; 
    	};

    }
  ;
}
