{ pkgs, ... }:
{
  hardware.graphics.enable = true;

  fonts.packages = with pkgs; [
    fontconfig
    dejavu_fonts
    liberation_ttf
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    twemoji-color-font
  ];
}
