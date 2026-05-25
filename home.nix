{ config, pkgs, ... }:
let
  commonAliases = import ./aliases.nix;
in
{

  home.username = "endotrizine";
  home.homeDirectory = "/home/endotrizine";

  # Версия должна совпадать с системной
  home.stateVersion = "25.11";

  # Пакеты только для этого юзера
  home.packages = import ./home-packages.nix { inherit pkgs; };
  
	programs.home-manager.enable = true;

	# KITTY
	programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrains Mono Nerd Font";
      size = 11;
    };
    settings = {
      cursor_shape = "beam";
      cursor_trail = 1;
      window_margin_width = "21.75";
      confirm_os_window_close = 0;
      shell = "fish";
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";
      "ctrl+plus" = "change_font_size all +1";
      "ctrl+equal" = "change_font_size all +1";
      "ctrl+minus" = "change_font_size all -1";
      "ctrl+0" = "change_font_size all 0";
    };
  };

	# NIRI
	xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

	# NVIM
	xdg.configFile."nvim/init.lua".source = ./nvim-init.lua;

	# FUZZEL
	programs.fuzzel = {
    enable = true;
    settings.colors = {
      background = "1e1e2eff";
      text = "cdd6f4ff";
      match = "89b4faff";
      selection = "585b70ff";
      selection-match = "89b4faff";
      selection-text = "cdd6f4ff";
      border = "b4befeff";
    	};
		};
		

	# FISH
	programs.fish = {
  	enable = true;
  	shellAliases = commonAliases;
  	shellInit = "set fish_greeting";
  	#functions = {
  	#  rebuild = ''
  	#    set flake (test -n "$argv[1]" && echo "$argv[1]" || echo "/etc/nixos#nixos")
  	#    sudo nixos-rebuild switch --flake $flake |& nom
  	#  '';
  	#  rebuild-dry = ''
  	#    set flake (test -n "$argv[1]" && echo "$argv[1]" || echo "/etc/nixos#nixos")
  	#    sudo nixos-rebuild dry-build --flake $flake |& nom
  	#  '';
  	#};
	};

	# STARSHIP
  programs.starship = {
   	enable = true;
   	enableFishIntegration = true;
  };
  xdg.configFile."starship.toml".source = ./starship.toml;
	# GIT
	 programs.git = {
    enable = true;
   	userName = "endotrizine";
	   userEmail = "starnicworld@gmail.com";
	   extraConfig = {
	     core.autocrlf = "input";
	     credential.helper = "store";
	     credential."https://github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
	     credential."https://gist.github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
	   };
	 };

  # MPV
  programs.mpv = {
    enable = true;
    config = {
      keep-open = "yes";
    };
  };
	# YAZI
	#xdg.configFile."yazi/yazi.toml".source = ./yazi-yazi.toml;

  # BTOP
  xdg.configFile."btop/btop.conf".source = ./btop.conf;


 }
