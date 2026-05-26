{
  description = "endotrizine nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, noctalia-shell, zen-browser, ... }@inputs:
    let
      mkSystem = host: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          (./hosts + "/${host}")
          noctalia-shell.nixosModules.default
					inputs.catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.endotrizine = {
						  imports = [
						    ./home/default.nix
						    inputs.catppuccin.homeModules.catppuccin
  						];
						};
          }
        ];
      };
    in {
      # `nixos-rebuild switch --flake /etc/nixos#<host>`
      # Current VM: hostname `nixos` lives in hosts/vm/.
      # When migrating to real hardware:
      #   1. Create hosts/<newname>/ with hardware-configuration.nix,
      #      a host-specific boot.nix and any other host-only modules.
      #   2. Add a line below: <newname> = mkSystem "<newname>";
      #   3. Rebuild: `sudo nixos-rebuild switch --flake /etc/nixos#<newname>`
      nixosConfigurations = {
        nixos = mkSystem "vm";
      };
    };
}
