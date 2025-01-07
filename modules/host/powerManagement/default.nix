{ config, lib, ... }:
let
  cfg = config.sorac.host;
in
{
  options.sorac.host.powerManagement = {
    enable = lib.mkEnableOption "power management";
  };

  config = lib.mkIf cfg.powerManagement.enable {
    hardware.nvidia = lib.mkIf cfg.nvidia.enable {
      powerManagement.finegrained = true;
      dynamicBoost.enable = true;
      prime.offload = lib.mkIf cfg.newIntel.enable {
        enable = true;
        enableOffloadCmd = true;
      };
    };

    powerManagement.enable = true;
    services = {
      thermald.enable = true;

      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "auto";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };

      upower.enable = true;
    };
  };
}
