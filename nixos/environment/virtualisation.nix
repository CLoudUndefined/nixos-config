{ ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.runAsRoot = false;
    };
    docker = {
      enable = true;
      storageDriver = "btrfs";
      enableOnBoot = false;
    };
  };
}
