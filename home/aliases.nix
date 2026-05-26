{
  # Uses current hostname → picks VM (`nixos`) or desktop (`desktop`) automatically.
  rebuild = "sudo -v; and sudo nixos-rebuild switch --flake /etc/nixos#(hostname) |& nom";
  rebuild-dry = "sudo nixos-rebuild dry-build --flake /etc/nixos#(hostname)";
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
  pushnix = "cd /etc/nixos && git add . && git commit -m 'update'; git push; cd -";
  gl = "git log --oneline --graph";
  gd = "git diff";

  v = "nvim";
  vi = "nvim";	

  top = "btop";
  c = "clear";
  ports = "ss -tulanp";
  hp = "nvim /etc/nixos/home/packages.nix";
}
