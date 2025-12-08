{ ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      CPU_DRIVER_OPMODE_ON_AC = "passive";
      CPU_DRIVER_OPMODE_ON_BAT = "passive";
      CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
      CPU_SCALING_GOVERNOR_ON_BAT = "conservative";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 80;

      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 85;

      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";
    };
  };
}
