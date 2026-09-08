{ pkgs, ... }:
{
  programs.virt-manager.enable = true;
	virtualisation.libvirtd = {
  	enable = true;
  	qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
	};
  virtualisation.docker.enable = true;
  users.users.endotrizine.extraGroups = [ "docker" ];
}
