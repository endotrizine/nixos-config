{
  rebuild = "nh os switch";
  
  rebuild-dry = "nh os test";
  
  nix-clean = "nh clean all --keep 3 --keep-since 7d";
  
  nix-update = "nix flake update --flake /etc/nixos";

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
  nixedit = "nvim /etc/nixos/";
}
