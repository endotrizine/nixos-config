# было: system/modules/networking.nix
{ ... }:
{
  flake.modules.nixos.common =
    { ... }:
    {
      networking.networkmanager.enable = true;
      # programs.clash-verge = {
      #   enable = true;
      #   serviceMode = true;
      #   tunMode = true;
      #   autoStart = true;
      # };

      networking.firewall = {
        trustedInterfaces = [ "Mihomo" ];
        extraReversePathFilterRules = ''
          			iifname { "Mihomo" } accept comment "trusted interface"
          		'';
      };
    }
  ;
}
