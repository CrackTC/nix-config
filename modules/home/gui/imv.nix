{ config, lib, ... }:
let cfg = config.imv; in {
  options.imv = {
    enable = lib.mkEnableOption "imv";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.imv.enable = true;
    xdg.mimeApps.defaultApplications = lib.genAttrs [
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
}
