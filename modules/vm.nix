{ ... }:
{
  # SPICE clipboard / dynamic resolution agent
  services.spice-vdagentd.enable = true;

  # Serial getty for `virsh console` access (recovery channel when SPICE+GL
  # path is unavailable from the host).
  systemd.services."serial-getty@ttyS0" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };
}
