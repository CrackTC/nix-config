{ config, lib, ... }:
let cfg = config.sorac.host.pipewire; in {
  options.sorac.host.pipewire = {
    enable = lib.mkEnableOption "pipewire";
    lowLatency = lib.mkEnableOption "pipewire audio low latency configuration";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
      extraConfig = lib.mkIf cfg.lowLatency {
        pipewire = {
          "10-low-latency" = {
            "context.properties" = {
              "default.clock.rate" = 44100;
              "default.clock.allowed-rates" = [ 44100 48000 ];
            };
          };
        };
        pipewire-pulse = {
          "10-low-latency" = {
            "context.properties" = {
              "pulse.min.req" = "1024/48000";
              "pulse.min.quantum" = "1024/48000";
            };
          };
        };
      };
    };
  };
}
