{ pkgs, ... }:
{

  fonts.packages = with pkgs; [
    fontconfig
    dejavu_fonts
    liberation_ttf
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    twemoji-color-font
  ];
	hardware.graphics = {
  	enable = true;
  	extraPackages = with pkgs; [ libva libva-vdpau-driver libvdpau-va-gl ];
	};
}
