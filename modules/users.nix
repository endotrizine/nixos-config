{ pkgs, ... }:
{
  users.users.endotrizine = {
    isNormalUser = true;
    description = "endotrizine";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "render" "kvm" ];
    shell = pkgs.fish;
    packages = [ ];
  };

  programs.fish.enable = true;
}
