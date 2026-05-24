{
  config,
  lib,
  ...
}:
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
    # https://wiki.nixos.org/wiki/Laptop
    powerManagement.enable = true;
    services = {
      thermald.enable = true;
      # needed by noctalia shell
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };
  };
}
