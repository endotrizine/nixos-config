{ pkgs, ... }:
{
  home.packages = [(pkgs.writeShellScriptBin "spf" "exec ${pkgs.superfile}/bin/superfile \"$@\"")];
}
