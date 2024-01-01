{info, ...}: {
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = info.email;
        password_cmd = "cat /run/secrets/spotify";
        use_mpris = true;
        backend = "alsa";
        device_name = "spotifyd";
        bitrate = 320;
        cache_path = "/home/${info.username}/.cache/spotifyd";
        no_audio_cache = false;
        volume_normalization = true;
        normalization_pregain = -10;
        autoplay = true;
        device_type = "computer";
        proxy = "http://127.0.0.1:7890";
      };
    };
  };
}
