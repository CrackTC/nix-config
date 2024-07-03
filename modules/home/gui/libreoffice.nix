{ config, pkgs, lib, ... }:
let cfg = config.libreoffice; in {
  options.libreoffice = {
    enable = lib.mkEnableOption "libreoffice";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.libreoffice-qt ];
    xdg.mimeApps.defaultApplications."application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
  };
}
