{ ... }:
{
  imports = [
    ../../modules
    ./hardware-configuration.nix
    ./boot.nix
    ./laptop.nix
  ];
   
  networking.hostName = "t14";
  system.stateVersion = "25.11";
  
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
	hardware.bluetooth.enable = true;
}
