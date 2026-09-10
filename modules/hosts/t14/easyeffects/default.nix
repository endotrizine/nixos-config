# было: hosts/t14/home/settings/easyeffects/default.nix
{ ... }:
{
  flake.modules.homeManager."hosts/t14" =
    { lib, ... }:
    let
      assetsDir = ./assets;

      presetFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".json" name) (
        builtins.readDir assetsDir
      );

      presetEntries = lib.mapAttrs' (
        name: _type: lib.nameValuePair "easyeffects/output/${name}" { source = assetsDir + "/${name}"; }
      ) presetFiles;

      irsDir = assetsDir + "/irs";

      irsFiles =
        if builtins.pathExists irsDir then
          lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".irs" name) (
            builtins.readDir irsDir
          )
        else
          { };

      irsEntries = lib.mapAttrs' (
        name: _type: lib.nameValuePair "easyeffects/irs/${name}" { source = irsDir + "/${name}"; }
      ) irsFiles;
    in
    {
      xdg.dataFile = presetEntries // irsEntries;
    };
}
