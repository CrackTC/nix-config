{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };
  environment.etc = {
    "pipewire/pipewire.conf.d/pipewire.conf" = {
      text = ''
      context.properties = {
        default.clock.rate = 44100;
        default.clock.min-quantum = 512;
        default.clock.allowed-rates = [ 44100 48000 ]
      };
      '';
    };
    "pipewire/pipewire.conf.d/pipewire-pulse.conf" = {
      text = ''
      context.properties = {
        pulse.min.req = 1024/48000
        pulse.min.quantum = 1024/48000
      };
      '';
    };
    "pipewire/pipewire.conf.d/alsa-monitor.conf" = {
      text = ''
      context.properties = {
        session.suspend-timeout-seconds = 0
        api.alsa.headroom = 1024
        api.alsa.period-size   = 256
        api.alsa.headroom      = 1024
      };
      '';
    };
  };
}
