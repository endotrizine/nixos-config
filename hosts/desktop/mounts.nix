{ ... }:
{
  # External data partitions carried over from Arch.
  # UUIDs captured from the live system before reinstall.
  # If UUIDs change (reformat), update them here.

  fileSystems."/mnt/storage1" = {
    device = "/dev/disk/by-uuid/6854BD5954BD2B28";   # sdc1, NTFS, 931G
    fsType = "ntfs3";
    options = [ "rw" "uid=1000" "gid=100" "umask=022" "nofail" ];
  };

  fileSystems."/mnt/storage2" = {
    device = "/dev/disk/by-uuid/e5554191-54f4-475e-b66b-2a5f8eb304e6";   # sda1, ext4, 223G
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };
}
