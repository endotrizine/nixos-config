{ ... }:
{
  imports = [
    ../../modules
    ./hardware-configuration.nix    # REPLACE with `nixos-generate-config --root /mnt` output before install
    ./boot.nix
    ./nvidia.nix
    ./mounts.nix
  ];

  networking.hostName = "desktop";
  system.stateVersion = "25.11";

  # AMD Ryzen 5 5500 microcode + firmware blobs
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
