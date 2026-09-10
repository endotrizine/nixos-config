# было: system/modules/users.nix
{ ... }:
{
  flake.modules.nixos.common =
    { pkgs, ... }:
    {
      users.users.endotrizine = {
        isNormalUser = true;
        description = "endotrizine";
        extraGroups = [ "networkmanager" "wheel" "video" "audio" "render" "kvm" "libvirtd" ];
        shell = pkgs.fish;
        packages = [ ];
      };

      programs.fish.enable = true;
    }
  ;
}
