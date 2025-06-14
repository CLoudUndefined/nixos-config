{ ... }:
{
  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;

        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersave";

        AHCI_RUNTIME_PM_ON_AC = "on";
        AHCI_RUNTIME_PM_ON_BAT = "auto";

        USB_AUTOSUSPEND = 1;
        USB_EXCLUDE_AUDIO = 1;

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
      };
    };
  };
}
