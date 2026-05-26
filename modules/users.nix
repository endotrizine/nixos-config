{ pkgs, ... }:
{
  users.users.endotrizine = {
    isNormalUser = true;
    description = "endotrizine";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "render" "kvm" ];
    shell = pkgs.fish;
    packages = [ ];
    # Bootstrap password applied only on first user creation. Change
    # immediately after first login via `passwd`. Existing accounts on
    # the VM are not affected (mutableUsers = true is the default).
    initialPassword = "endotrizine";
  };

  programs.fish.enable = true;
}
