{ pkgs, ... }: {
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "vivaldi-stable.desktop";
    "x-scheme-handler/https" = "vivaldi-stable.desktop";
    "text/plain" = "nvim.desktop";
  };

  home.packages = with pkgs; [ xdg-utils ];
}
