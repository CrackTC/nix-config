{ pkgs, lib, ... }: {
  # overwrite existing mimeapps.list
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      {
        "inode/directory" = "org.gnome.Nautilus.desktop";
      }

      // lib.genAttrs [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/about"
        "x-scheme-handler/unknown"
      ]
        (mime: "firefox.desktop")

      // lib.genAttrs [
        "application/pdf"
      ]
        (mime: "okularApplication_pdf.desktop")

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
        (mime: "imv.desktop");
  };

  xdg.userDirs = {
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

  home.packages = with pkgs; [ xdg-utils ];
}
