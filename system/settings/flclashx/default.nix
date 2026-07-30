# system/settings/flclashx/default.nix
#
# Системная часть FlClashX: сетевые capabilities для бинарников.
# HM-часть (autostart) — в home/settings/flclashx.nix

{ pkgs, inputs, ... }:
{
  security.wrappers = {
    FlClashCore = {
      owner = "root";
      group = "root";
      capabilities = "cap_net_admin,cap_net_bind_service=+ep";
      source = "${inputs.flclashx.packages.${pkgs.system}.default}/bin/FlClashCore";
    };

    FlClashX = {
      owner = "root";
      group = "root";
      capabilities = "cap_net_admin,cap_net_bind_service=+ep";
      source = "${inputs.flclashx.packages.${pkgs.system}.default}/bin/FlClashX";
    };
  };
}
