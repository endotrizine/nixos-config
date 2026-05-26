{ ... }:
{
  # hostName is set per-host in hosts/<name>/default.nix.
  networking.networkmanager.enable = true;
	programs.clash-verge = {
		enable = true;
		serviceMode = true;
		tunMode = true;
		autoStart = true;
	};

	networking.firewall = {
		trustedInterfaces = [ "Mihomo" ];
		extraReversePathFilterRules= ''
			iifname { "Mihomo" } accept comment "trusted interface"
		'';
	};
}
