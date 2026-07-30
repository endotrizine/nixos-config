{ pkgs, inputs, ... }:
{

  # 1. Выдаем сетевые права обоим бинарникам
  security.wrappers = {
    FlClashCore = {
      owner = "root";
      group = "root";
      capabilities = "cap_net_admin,cap_net_bind_service=+ep";
      source = "${inputs.flclashx.packages.${pkgs.system}.default}/bin/FlClashCore";
    };

    # Сам GUI запуск через wrapper
    FlClashX = {
      owner = "root";
      group = "root";
      capabilities = "cap_net_admin,cap_net_bind_service=+ep";
      source = "${inputs.flclashx.packages.${pkgs.system}.default}/bin/FlClashX";
    };
  };


  # home.nix
  xdg.configFile."autostart/flclashx.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=FlClashX
    Exec=FlClashX --minimized
    Icon=FlClashX
    Terminal=false
    Categories=Network;
    X-GNOME-Autostart-enabled=true
  '';
}
