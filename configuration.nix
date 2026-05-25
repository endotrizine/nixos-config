# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  boot.kernelParams = [
    "video=efifb:off"
    "video=vesafb:off"
    "drm.debug=0" 
    "video=virtio:off"
    "drm_kms_helper.fbdev_emulation=0"
    "fbcon=map:99"
  ];
  boot.initrd.kernelModules = [ "virtio_gpu" ];
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Yekaterinburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ru";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.endotrizine = {
    isNormalUser = true;
    description = "endotrizine";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "render" "kvm" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # --- СИСТЕМНЫЕ СЛУЖБЫ ДЛЯ iNiR ---
  security.polkit.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  
  # Включаем PipeWire (звуковой стек)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Драйверы и графика
  hardware.graphics.enable = true;

  # Настройка шрифтов (NixOS 25.11 way)
  fonts.packages = with pkgs; [
    fontconfig
    dejavu_fonts
    liberation_ttf
    nerd-fonts.jetbrains-mono # Исправлено под 25.11
    nerd-fonts.symbols-only   # Исправлено под 25.11
    twemoji-color-font
  ];

  # PACKAGES
  environment.systemPackages = import ./packages.nix { inherit pkgs inputs; };

  services.openssh.enable = true;
  services.spice-vdagentd.enable = true;
  # Дисплейный менеджер
  services.xserver.enable = false;
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;
  programs.niri.enable = true;
  console = {
    font = "cyr-sun16";
  };
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Serial getty for `virsh console` access (recovery channel)
  systemd.services."serial-getty@ttyS0" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };

  # greetd: auto-login endotrizine, auto-start niri-session on seat0
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = "endotrizine";
      };
    };
  };

  system.stateVersion = "25.11";

	users.users.endotrizine.shell = pkgs.fish;
  programs.fish.enable = true;	

}
