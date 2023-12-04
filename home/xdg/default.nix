{ pkgs, lib, ... }: {
  # overwrite existing mimeapps.list
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      {
        "inode/directory" = "nemo.desktop";
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
        (mime: "okularApplication_pdf.desktop");
  };

  home.packages = with pkgs; [ xdg-utils ];
}
