{ ... }:
{
  imports = [
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./users.nix
    ./audio.nix
    ./graphics.nix
    ./desktop.nix
    ./vm.nix
    ./services.nix
    ./nix-settings.nix
    ./packages.nix
  ];
}
