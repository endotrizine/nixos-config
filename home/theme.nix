{ pkgs, ... }:

{
  catppuccin.enable = true;
  catppuccin.flavor = "mocha"; 
  catppuccin.accent = "lavender"; 
	
	gtk = {
    enable = true;
    
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        tweaks = [ ];
        variant = "mocha";
      };
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Classic";
  	package = pkgs.bibata-cursors;
		size = 24;
  };
}
