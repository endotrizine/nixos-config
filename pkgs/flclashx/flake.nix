{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        version = "0.4.2";

        src = pkgs.fetchFromGitHub {
          owner = "pluralplay";
          repo = "FlClashX";
          rev = "v${version}";
          hash = "sha256-TBUBRG8I96QM0qhyugIOATJD9GwMGwakg0z8tFjIf0Y=";
        };

        flclashCore = pkgs.buildGoModule {
          pname = "flclashx-core";
          inherit version src;

          modRoot = "core";
          vendorHash = "sha256-BsFT/KrD8SX3edFtipK/eaJvVopvOCmTiw+Ydh+oa0s=";

          env = {
            CGO_ENABLED = "0";
          };

          buildPhase = ''
            runHook preBuild

            go build \
              -tags=with_gvisor \
              -trimpath \
              -ldflags="-w -s -X github.com/metacubex/mihomo/constant.Version=${version}" \
              -o FlClashCore .

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            install -Dm755 FlClashCore $out/bin/FlClashCore

            runHook postInstall
          '';

          doCheck = false;
        };

        flclashx = pkgs.flutter.buildFlutterApplication {
          pname = "flclashx";
          inherit version src;

          pubspecLock = builtins.fromJSON (
            builtins.readFile (
              pkgs.runCommand "pubspec.lock.json" {} ''
                ${pkgs.yq-go}/bin/yq -o=json ${src}/pubspec.lock > $out
              ''
            )
          );

          gitHashes = {
            flutter_js = "sha256-4PgiUL7aBnWVOmz2bcSxKt81BRVMnopabj5LDbtPYk4=";
          };

          preBuild = ''
            mkdir -p libclash/linux
            cp ${flclashCore}/bin/FlClashCore libclash/linux/FlClashCore
          '';

          nativeBuildInputs = with pkgs; [
            pkg-config
            wrapGAppsHook3
          ];

          buildInputs = with pkgs; [
            gtk3
            glib
            gdk-pixbuf
            cairo
            pango
            atk
            harfbuzz
            libepoxy
            libayatana-appindicator
            keybinder3
            libX11
            libXcursor
            libXrandr
            libXinerama
            libXi
          ];

          meta = with pkgs.lib; {
            mainProgram = "FlClashX";
          };
        };
      in
      {
        packages = rec {
          default = flclashx;
          inherit flclashx;
          flclashx-core = flclashCore;
        };
      }
    );
}
