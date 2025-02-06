{
  disks ? [ "/dev/sda" ],
  ...
}:
{
  disko.devices = {
    disk = {
      my-disk = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            BIOS = {
              size = "1M";
              type = "EF02";
            };
            ESP = {
              size = "512M";
              name = "esp";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/efi";
              };
            };
            BOOT = {
              size = "1G";
              name = "boot";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            PRIMARY = {
              size = "100%";
              name = "primary";
              content = {
                type = "lvm_pv";
                vg = "teimoncloud";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      teimoncloud = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "16G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "@" = {
                  mountpoint = "/";
                  mountOptions = [
                    "subvol=@"
                    "compress=zstd"
                    "noatime"
                    "ssd"
                    "space_cache=v2"
                  ];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "subvol=@home"
                    "compress=zstd"
                    "noatime"
                    "ssd"
                    "space_cache=v2"
                  ];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "subvol=@nix"
                    "compress=zstd"
                    "noatime"
                    "ssd"
                    "space_cache=v2"
                  ];
                };
                "@var" = {
                  mountOptions = [
                    "subvol=@var"
                    "compress=zstd"
                    "noatime"
                    "ssd"
                    "space_cache=v2"
                  ];
                  mountpoint = "/var";
                };
              };
            };
          };
        };
      };
    };
  };
}
