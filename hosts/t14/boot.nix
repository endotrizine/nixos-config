{ pkgs, ...}:
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

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };

  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" "splash" "loglevel=3" "rd.system.show_status=false" "pcie_aspm=off" "rd.udev.log_level=3" "udev.log_level=3" ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.tmp.useTmpfs = true;
  boot.tmp.cleanOnBoot = true;
}
