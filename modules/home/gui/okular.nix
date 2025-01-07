{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.okular;
in
{
  options.okular = {
    enable = lib.mkEnableOption "okular";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = [ pkgs.libsForQt5.okular ];
    xdg.mimeApps.defaultApplications."application/pdf" = "okularApplication_pdf.desktop";
  };
}
