{ config, pkgs, ... }:
{
  # NVIDIA GeForce RTX 3050 (GA106, Ampere). Using NVIDIA's *open kernel
  # module* (open = true). This is NOT nouveau — it's NVIDIA's own MIT/GPL
  # kernel module (515+) paired with the proprietary userspace. Recommended
  # by NVIDIA for Turing+ (incl. Ampere). Better compatibility with bleeding
  # kernels and faster binary cache hits in nixpkgs.
  #
  # If something is broken, flip to proprietary kernel module: `open = false;`.
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  # Make sure 32-bit GL libs are available (Steam, Wine, etc.).
  hardware.graphics.enable32Bit = true;
}
