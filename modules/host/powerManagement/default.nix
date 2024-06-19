{ config, lib, ... }:
let cfg = config.sorac.host; in {
  options.sorac.host.powerManagement = {
    enable = lib.mkEnableOption "power management";
  };

  config = lib.mkIf cfg.powerManagement.enable {
    hardware.nvidia = lib.mkIf cfg.nvidia.enable {
      powerManagement.finegrained = true;
      prime.offload = lib.mkIf cfg.newIntel.enable {
        enable = true;
        enableOffloadCmd = true;
      };
    };


    powerManagement.enable = true;
    services = {
      thermald.enable = true;

      # auto-cpufreq = {
      #   enable = true;
      #   settings = {
      #     battery = {
      #       governor = "powersave";
      #       turbo = "never";
      #     };
      #     charger = {
      #       governor = "performance";
      #       turbo = "auto";
      #     };
      #   };
      # };

      tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          # Optional, helps save long term battery health
          START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
          STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
        };
      };

      upower.enable = true;
    };
  };
}
