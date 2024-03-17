{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
    extraConfig = {
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
}
