{ ... }:
{
  imports = [
    ../../modules           # host-agnostic NixOS modules
    ./hardware-configuration.nix
    ./boot.nix              # VM bootloader + virtio framebuffer workaround
    ./vm.nix                # spice-vdagentd, serial-getty for `virsh console`
  ];

  networking.hostName = "nixos";
  system.stateVersion = "25.11";
}
