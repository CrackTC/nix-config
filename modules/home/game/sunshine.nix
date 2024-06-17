{ config, pkgs, lib, hostConfig, ... }:
let cfg = config.sunshine; in {
  options.sunshine = {
    enable = lib.mkEnableOption "sunshine";
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      home.packages = with pkgs; [
        (sunshine.override { cudaSupport = hostConfig.nvidia.enable; })
      ];
    };

    # Enable Avahi service discovery
    osConfig = {
      services.avahi.enable = true;
      services.avahi.publish.userServices = true;
    };
  };
}
