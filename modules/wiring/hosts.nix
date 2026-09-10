# Единственное место, где flake.modules.* превращается в реальные
# nixosConfigurations. Это тот самый "escape hatch", который есть в любом
# дендритик-конфиге — flake-parts сознательно не даёт встроенной опции
# для инстанцирования конфигураций (см. github.com/mightyiam/dendritic,
# discussion #3), так что этот файл пишется руками один раз.
{ config, inputs, ... }:
let
  mkHost =
    hostName:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
        host = hostName;
      };

      modules = [
        config.flake.modules.nixos.common
        config.flake.modules.nixos."hosts/${hostName}"

        inputs.noctalia-shell.nixosModules.default
        inputs.catppuccin.nixosModules.catppuccin
        inputs.home-manager.nixosModules.home-manager
        inputs.koala-clash.nixosModules.default

        {
          nixpkgs.overlays = [
            inputs.flclashx.overlays.default
            inputs.koala-clash.overlays.default
          ];

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "nix_bak";

          home-manager.extraSpecialArgs = {
            inherit inputs;
            host = hostName;
          };

          home-manager.users.endotrizine = {
            imports = [
              config.flake.modules.homeManager.common
              config.flake.modules.homeManager."hosts/${hostName}"
              inputs.catppuccin.homeModules.catppuccin
              inputs.lazyvim.homeManagerModules.default
            ];
          };
        }
      ];
    };
in
{
  flake.nixosConfigurations = {
    desktop = mkHost "desktop";
    t14 = mkHost "t14";
  };
}
