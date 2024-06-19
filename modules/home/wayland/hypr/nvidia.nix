{ config, lib, ... }:
let cfg = config.hypr; in {
  config.hmConfig = lib.mkIf (cfg.useNvidia && cfg.enable) {
    wayland.windowManager.hyprland = {
      enableNvidiaPatches = true;
      settings = {
        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ];
      };
    };
  };
}
