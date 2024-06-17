{ config, lib, ... }:
let cfg = config.hypr; in {
  config.hmConfig = lib.mkIf (!cfg.useNvidia && cfg.enable) {
    wayland.windowManager.hyprland.settings.env = [
      "__EGL_VENDOR_LIBRARY_FILENAMES,/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json"
      # "WLR_DRM_DEVICES,/dev/dri/card1"
    ];
  };
}
