{ pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  # Disable kernel framebuffer paths that conflict with virtio-gpu / niri.
  # fbcon=map:99 detaches the kernel console from the virtio framebuffer so
  # niri can claim DRM master cleanly.
  boot.kernelParams = [
    "video=efifb:off"
    "video=vesafb:off"
    "video=virtio:off"
    "drm.debug=0"
    "drm_kms_helper.fbdev_emulation=0"
    "fbcon=map:99"
  ];

  boot.initrd.kernelModules = [ "virtio_gpu" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
