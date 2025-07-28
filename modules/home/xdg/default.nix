{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.xdg;
in
{
  options.xdg = {
    enable = lib.mkEnableOption "xdg settings";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    xdg = {
      # overwrite existing mimeapps.list
      configFile."mimeapps.list".force = true;
      mimeApps = {
        enable = true;
        defaultApplications = lib.genAttrs [
          "text/html"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/about"
          "x-scheme-handler/unknown"
        ] (mime: if config.chrome.enable then "google-chrome.desktop" else "firefox.desktop");
      };

      userDirs = {
        enable = true;
        desktop = "Desktop";
        documents = "Documents";
        download = "Downloads";
        music = "Music";
        pictures = "Pictures";
        publicShare = "Public";
        templates = "Templates";
        videos = "Videos";
      };
    };

    home.packages = with pkgs; [
      xdg-utils
      xdg-terminal-exec
    ];
  };
}
