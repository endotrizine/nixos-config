{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    configurationLimit = 10;
  };

  catppuccin.grub = {
    enable = true;
    flavor = "mocha";
  };

  # Анимированный логотип NixOS
  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };

  boot.initrd.systemd.enable = true;
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" ];

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_level=3"
    "vt.global_cursor_default=0"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.tmp.useTmpfs = true;
  boot.tmp.cleanOnBoot = true;
}
