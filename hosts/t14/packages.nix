{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
		steam
		prismlauncher
	];
}
