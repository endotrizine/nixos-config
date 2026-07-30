{ pkgs, ... }:
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
	systemd.user.services.fifine-mute-loopback = {
  	description = "Mute Fifine mic loopback/sidetone";
  	wantedBy = [ "default.target" ];
  	after = [ "pipewire.service" "sound.target" ];
  	serviceConfig = {
    	Type = "oneshot";
    	RemainAfterExit = true;
    	ExecStart = "${pkgs.alsa-utils}/bin/amixer -c Microphone sset Mic mute";
  	};
	};
}
