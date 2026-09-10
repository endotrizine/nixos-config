# было: hosts/t14/home/packages.nix
{ ... }:
{
  flake.modules.homeManager."hosts/t14" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        prismlauncher
      ];
    };
}
