{ config, pkgs, lib, inputs, ... }: 

let
  importFromDir = dir:
    let
      files = builtins.readDir dir;
      
      nixFiles = lib.filterAttrs 
        (name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix") 
        files;
    in
    map (name: dir + "/${name}") (builtins.attrNames nixFiles);
in
{
  imports = [
    inputs.nixcord.homeModules.nixcord
    ./theme.nix
  ] ++ (importFromDir ./programs); 
	home.username = "endotrizine";
  home.homeDirectory = "/home/endotrizine";
  home.stateVersion = "25.11";

  home.packages = import ./packages.nix { inherit pkgs; };

  programs.home-manager.enable = true;
}
