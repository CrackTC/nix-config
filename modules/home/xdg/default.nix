{ config, pkgs, lib, ... }:
let cfg = config.xdg; in {
  options.xdg = {
    enable = lib.mkEnableOption "xdg settings";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    xdg = {
      # overwrite existing mimeapps.list
      configFile."mimeapps.list".force = true;
      mimeApps = {
        enable = true;
        defaultApplications =
          {
            "inode/directory" = lib.mkIf config.nautilus.enable "org.gnome.Nautilus.desktop";
          }

          // lib.genAttrs [
            "text/html"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/about"
            "x-scheme-handler/unknown"
          ]
            (mime: if config.firefox.enable then "firefox.desktop" else "vivaldi-stable.desktop")

          // lib.genAttrs [
            "application/pdf"
          ]
            (mime: lib.mkIf config.okular.enable "okularApplication_pdf.desktop")

          // lib.genAttrs [
            "image/bmp"
            "image/gif"
            "image/jpeg"
            "image/jpg"
            "image/pjpeg"
            "image/png"
            "image/tiff"
            "image/x-bmp"
            "image/x-pcx"
            "image/x-png"
            "image/x-portable-anymap"
            "image/x-portable-bitmap"
            "image/x-portable-graymap"
            "image/x-portable-pixmap"
            "image/x-tga"
            "image/x-xbitmap"
            "image/x-heif"
          ]
            (mime: lib.mkIf config.imv.enable "imv.desktop")

          // lib.genAttrs [
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
          ]
            (mime: lib.mkIf config.libreoffice.enable "writer.desktop");
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

    home.packages = with pkgs; [ xdg-utils ];
  };
}
