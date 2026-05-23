{ config, lib, ... }:
let
  cfg = config.hypr;
in
{
  config.hmConfig.wayland.windowManager.hyprland.extraConfig =
    lib.mkIf (cfg.useNvidia && cfg.enable)
      # lua
      ''
        hl.env("GBM_BACKEND", "nvidia-drm")
        hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
        hl.env("LIBVA_DRIVER_NAME", "nvidia")
      '';
}
