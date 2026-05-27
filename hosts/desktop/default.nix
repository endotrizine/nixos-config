{ ... }:
{
  imports = [
    ../../modules
    ./hardware-configuration.nix    
		./boot.nix
    ./nvidia.nix
    #./mounts.nix
  ];

  networking.hostName = "desktop";
  system.stateVersion = "25.11";

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
