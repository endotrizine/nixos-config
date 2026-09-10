# было: home/default.nix
#
# Базовые home-manager настройки, общие для всех хостов.
# Раньше здесь же жила resolveSettings-магия (host-override по имени
# файла/папки) — в дендритик-паттерне это больше не нужно: каждый
# файл сам решает, к какому имени (common / hosts/<host>) он
# контрибьютит, а объединение делает сама модульная система Nix.
{ inputs, ... }:
{
  flake.modules.homeManager.common = {
    imports = [
      inputs.nixcord.homeModules.nixcord
    ];

    home.username = "endotrizine";
    home.homeDirectory = "/home/endotrizine";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;
  };
}
