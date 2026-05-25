{
  rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
  rebuild-dry = "sudo nixos-rebuild dry-build --flake /etc/nixos#nixos";
  nix-clean = "sudo nix-collect-garbage -d";
  nix-update = "sudo nix flake update /etc/nixos";

  l = "eza -lah";
  ls = "eza";
  tree = "eza --tree --git-ignore";
  cat = "bat";
  mk = "mkdir -p";

  ".." = "cd ..";
  "..." = "cd ../..";

  g = "git";
  gs = "git status";
  ga = "git add";
  gc = "git commit";
  gp = "git push";
  gl = "git log --oneline --graph";
  gd = "git diff";

  v = "nvim";
  vi = "nvim";

  top = "btop";
  c = "clear";
  ports = "ss -tulanp";
	hp = "nvim /etc/nixos/home-packages.nix";
}
