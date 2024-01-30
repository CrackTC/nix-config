{ extraRepos, pkgs, ... }: {
  home.packages = with extraRepos; with pkgs; [
    myRepo.beatoraja
    yuzu-mainline
    osu-lazer-bin

    # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
    gst_all_1.gstreamer
    # Common plugins like "filesrc" to combine within e.g. gst-launch
    gst_all_1.gst-plugins-base
    # Specialized plugins separated by quality
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    # Plugins to reuse ffmpeg to play almost every video format
    gst_all_1.gst-libav
    # Support the Video Audio (Hardware) Acceleration API
    gst_all_1.gst-vaapi

    (cataclysm-dda-git.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "CleverRaven";
        repo = "Cataclysm-DDA";
        rev = "9ffcd2bb42b84ee4a8d13d5eb549a95cfeb19b0d";
        hash = "sha256-zpYf1NVxCBZyf5BvUocaEfEUlsKp8dGGWwobTjKv1UM=";
      };
      patches = [ ];
    }))

    bottles

    gamescope
  ];
}
