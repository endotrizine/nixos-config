{
  description = "endotrizine nixos config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, noctalia-shell, home-manager, zen-browser, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
			specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        noctalia-shell.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.endotrizine = import ./home.nix;
        }
      ];
    };
  };
}
