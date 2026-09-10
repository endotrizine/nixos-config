# было: system/settings/nix-ld.nix
{ ... }:
{
  flake.modules.nixos.common =
    { pkgs, ... }:
    {
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc.lib
          zlib
          icu        # Крайне важен для .NET (интернационализация)
          openssl    # Нужен для сетевых запросов внутри LSP
          curl
        ];
      };


    }
  ;
}
