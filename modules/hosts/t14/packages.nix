# было: hosts/t14/system/packages.nix
{ ... }:
{
  flake.modules.nixos."hosts/t14" =
    # hosts/t14/system/packages.nix
    #
    # NixOS-модуль: системные пакеты только для этого хоста (t14),
    # не устанавливаются на desktop.

    { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        steam
      ];
    }
  ;
}
