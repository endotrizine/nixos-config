{ pkgs, ...}:
{
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
  services.logind.settings.Login.HandleLidSwitch = "suspend";
  services.libinput.enable = true;
  services.libinput.touchpad.tapping = true;
	services.fprintd.enable = true;

	security.pam.services = {
  	login.fprintAuth = true;
  
  	sudo.fprintAuth = true;

  };
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

	services.tlp.settings = {
  	CPU_SCALING_GOVERNOR_ON_AC = "performance";
  	CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  	CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  	CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  	CPU_MAX_PERF_ON_BAT = 60;
  	START_CHARGE_THRESH_BAT0 = 40;
  	STOP_CHARGE_THRESH_BAT0 = 80;
  	RUNTIME_PM_ON_AC = "auto";
  	RUNTIME_PM_ON_BAT = "auto";
	};

	zramSwap = {
  	enable = true;
  	algorithm = "zstd";
  	memoryPercent = 60;
  	priority = 100;
	};
	boot.kernel.sysctl."vm.swappiness" = 100;
	systemd.oomd.enable = true;

	services.fwupd.enable = true;
}
