{ ... }:
{
  # Legacy BIOS boot on virtio-blk. Host uses /dev/vda.
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  # virtio-gpu DRM in initrd so niri / virgl come up early.
  boot.initrd.kernelModules = [ "virtio_gpu" ];

  # Detach kernel framebuffer / console from virtio-gpu so niri can take
  # DRM master cleanly. These params are tuned for QEMU + virtio-vga-gl
  # and are NOT meaningful on real hardware.
  boot.kernelParams = [
    "video=efifb:off"
    "video=vesafb:off"
    "video=virtio:off"
    "drm.debug=0"
    "drm_kms_helper.fbdev_emulation=0"
    "fbcon=map:99"
  ];
}
