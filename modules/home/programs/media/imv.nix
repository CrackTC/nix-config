{ config, lib, ... }:
let
  cfg = config.programs.media.imv;
in
{
  options.programs.media.imv = {
    enable = lib.mkEnableOption "imv";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    programs.imv.enable = true;

    xdg.configFile."imv/config".text = ''
      [options]
      background=2e3440
      fullscreen=true
      suppress_default_binds=true

      [binds]
      <Shift+D>=goto -1
      <Shift+H>=prev
      <Shift+I>=next
      dd=goto 1
      e=pan 0 50
      f=fullscreen
      h=pan 50 0
      i=pan -50 0
      n=pan 0 -50
      p=rotate by 90
      q=quit
      u=zoom 1
      y=zoom -1
    '';

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
    ] (mime: "imv-dir.desktop");
  };
}
