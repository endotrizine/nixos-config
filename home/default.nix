{ pkgs, ... }:
{
  imports = [
    ./programs/fish.nix
    ./programs/kitty.nix
    ./programs/fuzzel.nix
    ./programs/starship.nix
    ./programs/git.nix
    ./programs/mpv.nix
    ./programs/btop.nix
    ./programs/niri.nix
    ./programs/neovim.nix
  ];

  home.username = "endotrizine";
  home.homeDirectory = "/home/endotrizine";
  home.stateVersion = "25.11";

  home.packages = import ./packages.nix { inherit pkgs; };

  programs.home-manager.enable = true;
	catppuccin = {
  	enable = true;
  	flavor = "mocha";
	};
	catppuccin.cache.enable = true;
	home.pointerCursor = {
  	gtk.enable = true;
  	x11.enable = true;
  	name = "Bibata-Modern-Classic";
  	package = pkgs.bibata-cursors;
  	size = 24;
	};
}
