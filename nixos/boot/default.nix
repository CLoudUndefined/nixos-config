{
  config,
  lib,
  ...
}:
let
  kernelVersion = config.boot.kernelPackages.kernel.version;
in
{
  boot = {
    plymouth.enable = true;
    kernel.sysctl."vm.dirty_writeback_centisecs" = 1500;
    initrd = {
      verbose = false;
      compressor = "zstd";
      compressorArgs = [
        "-3"
      ];
      kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_drm"
      ];
    };
    consoleLogLevel = 0;

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=0"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=0"
      "udev.log_priority=0"
      "udev.log_level=0"
      "vt.global_cursor_default=0"
      "nowatchdog"
      "acpi_osi=!"
      "acpi_osi=\"Windows 2015\""
      "i915.enable_psr=1"
      "nvme.noacpi=1"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="VirtualCam"
    '';
    kernelPatches =
      lib.optionals (lib.versionOlder kernelVersion "6.6") [
        {
          name = "intel_display_patch";
          patch = ../../src/patches/intel_display.u6.6.patch;
        }
      ]
      ++ lib.optionals (lib.versionAtLeast kernelVersion "6.6" && lib.versionOlder kernelVersion "6.12") [
        {
          name = "intel_bios_patch";
          patch = ../../src/patches/intel_bios.c.a6.6.patch;
        }
      ]
      ++ lib.optionals (lib.versionAtLeast kernelVersion "6.12") [
        {
          name = "intel_bios_patch_alt";
          patch = ../../src/patches/intel_bios.c.a6.11.patch;
        }
      ];
    loader = {
      timeout = lib.mkDefault 0;
      systemd-boot.enable = true;
      efi = {
        efiSysMountPoint = "/efi";
        canTouchEfiVariables = true;
      };
    };
  };
}
