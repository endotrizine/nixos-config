{ ... }:
{
	nix.settings = {
  	experimental-features = [ "nix-command" "flakes" ];
  	auto-optimise-store = true;
    substituters = [
     "https://cache.nixos.org"
     "https://nix-community.cachix.org"
   ];
	};
	nixpkgs.config.allowUnfree = true;

	#nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 14d"; };
	programs.nh = {
  	enable = true;
  	clean.enable = true;
  	clean.extraArgs = "--keep-since 4d --keep 3";
  	flake = "/etc/nixos";
	};



}
