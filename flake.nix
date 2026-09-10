{
  description = "endotrizine nixos config — дендритик-паттерн (flake-parts + import-tree)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:FlameFlag/nixcord";
    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flclashx.url = "github:endotrizine/FlClashX/nix-flake";
    koala-clash.url = "github:endotrizine/koala-clash-nix";
    lazyvim.url = "github:pfassina/lazyvim-nix";

    # Свой flake devenv — берём CLI напрямую из апстрима, чтобы не ждать,
    # пока кто-то вручную забампает версию в nixpkgs (это не автоматика).
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        # Даёт опцию flake.modules.<class>.<name> — основной механизм
        # дендритик-паттерна (без этого импорта опция не существует).
        inputs.flake-parts.flakeModules.modules

        # Рекурсивно подхватывает КАЖДЫЙ .nix файл из ./modules как
        # отдельный flake-parts модуль. Новый файл — новая фича,
        # ничего руками в imports дописывать не нужно.
        (inputs.import-tree ./modules)
      ];
    };
}
