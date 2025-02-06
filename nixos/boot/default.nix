{ config, lib, pkgs, ... }:
let
  kernelVersion = config.boot.kernelPackages.kernel.version;
in
{
  boot = {
    plymouth.enable = false;
    initrd.verbose = false;
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
    ];
    kernelPatches =
      lib.optionals (lib.versionOlder kernelVersion "6.6") [
        {
          name = "intel_display_patch";
          patch = ../../src/patches/intel_display.c.patch;
        }
      ]
      ++ lib.optionals (lib.versionAtLeast kernelVersion "6.6") [
        {
          name = "intel_bios_patch";
          patch = ../../src/patches/intel_bios.c.patch;
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
