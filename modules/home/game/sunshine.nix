{
  config,
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  cfg = config.game.sunshine;
in
{
  options.game.sunshine = {
    enable = lib.mkEnableOption "sunshine";
  };

  config = lib.mkIf cfg.enable {
    osConfig = {
      services = {
        sunshine = {
          enable = true;
          package = pkgs.sunshine.override {
            cudaSupport = hostConfig.nvidia.enable;
          };
          autoStart = false;
          openFirewall = true;
          capSysAdmin = true;
        };
        avahi.enable = true;
        avahi.publish.userServices = true;
      };
    };
  };
}
