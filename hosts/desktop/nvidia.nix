{ config, pkgs, ... }:
{
  # NVIDIA GeForce RTX 3050 (GA106, Ampere) — proprietary driver.
  # For open-source NVIDIA driver (NVK), set `open = true;`. The proprietary
  # driver is more battle-tested for niri + Wayland today.
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  # Make sure 32-bit GL libs are available (Steam, Wine, etc.).
  hardware.graphics.enable32Bit = true;
}
