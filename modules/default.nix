{ ... }:
{
  # Host-agnostic modules. Anything VM- or hardware-specific belongs
  # under hosts/<name>/.
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
  ];
}
