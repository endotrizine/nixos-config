{ ... }:
{
	services.syncthing = {
  	enable = true;
  	user = "endotrizine"; 
  	dataDir = "/home/endotrizine/.local/share/syncthing";
  	configDir = "/home/endotrizine/.config/syncthing";
  	
		guiAddress = "127.0.0.1:8384";
	};
	
	networking.firewall.allowedTCPPorts = [ 22000 ];
	networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
