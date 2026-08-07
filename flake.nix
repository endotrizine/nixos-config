{
  description = "endotrizine nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:FlameFlag/nixcord";
    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flclashx.url = "github:endotrizine/FlClashX/nix-flake";
    koala-clash.url = "github:endotrizine/koala-clash-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      noctalia-shell,
      flclashx,
      koala-clash,
      nixcord,
      ...
    }@inputs:
    let
      mkSystem =
        host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs host;
          };

          modules = [
            (./hosts + "/${host}")

            noctalia-shell.nixosModules.default
            inputs.catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            koala-clash.nixosModules.default

            {
              # FlClashX overlay
              nixpkgs.overlays = [
                flclashx.overlays.default
                koala-clash.overlays.default
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.backupFileExtension = "nix_bak";

              home-manager.extraSpecialArgs = {
                inherit inputs host;
              };

              home-manager.users.endotrizine = {
                imports = [
                  ./home/default.nix
                  inputs.catppuccin.homeModules.catppuccin
                ];
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        desktop = mkSystem "desktop";
        t14 = mkSystem "t14";
      };
    };
}
