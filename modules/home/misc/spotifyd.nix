{ config, lib, extraRepos, ... }:
let
  cfg = config.spotifyd;
  username = config._module.args.name;
in
{
  options.spotifyd = {
    enable = lib.mkEnableOption "spotifyd";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    services.spotifyd = {
      enable = true;
      package = extraRepos.pkgs-master.spotifyd;
      settings = {
        global = {
          username = config.email;
          password_cmd = "cat /run/secrets/spotify";
          use_mpris = true;
          backend = "alsa";
          device_name = "spotifyd";
          bitrate = 320;
          cache_path = "/home/${username}/.cache/spotifyd";
          no_audio_cache = false;
          volume_normalization = true;
          normalization_pregain = -10;
          autoplay = true;
          device_type = "computer";
          proxy = lib.mkIf config.clash.enable "http://127.0.0.1:7890";
        };
      };
    };
  };
}
