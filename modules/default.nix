{ ... }:
{
  imports = [
    ./kernel.nix
    ./locale.nix
    ./networking.nix
    ./users.nix
    ./audio.nix
    ./graphics.nix
    ./desktop.nix
    ./services.nix
    ./nix-settings.nix
    ./packages.nix
		./virtualization.nix
  ];
}
