{ ... }:
{
  # UEFI + systemd-boot. Picks up Windows on /dev/sdb automatically.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Limit how many old generations clutter the boot menu.
  boot.loader.systemd-boot.configurationLimit = 10;

  # NVIDIA + Wayland requirements
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    # Preserve VRAM contents across suspend/resume (helps with NVIDIA quirks).
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  # Enable rebuild-friendly tmp on tmpfs (optional).
  boot.tmp.cleanOnBoot = true;
}
