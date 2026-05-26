# !!! PLACEHOLDER !!!
#
# Replace this file with the output of:
#   nixos-generate-config --root /mnt
# after partitioning, BEFORE running `nixos-install --flake ... #desktop`.
#
# The generated file MUST define:
#   - fileSystems."/"      (your new root, btrfs subvolume @)
#   - fileSystems."/home"  (btrfs subvolume @home)
#   - fileSystems."/boot"  (vfat ESP)
#   - boot.initrd.availableKernelModules
#   - hardware.cpu.amd / nixpkgs.hostPlatform
#
# Until then this stub keeps the flake evaluating so you can dry-build.

{ ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/PLACEHOLDER-ROOT";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/PLACEHOLDER-ESP";
    fsType = "vfat";
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
