{ config, lib, hostConfig, ... }:
let
  cfg = config.hypr;
  username = config._module.args.name;

  path = with hostConfig.newIntel.pciBusId;
    "pci-${domain}:${bus}:${slot}.${function}-card";
in
{
  config = lib.mkIf (!cfg.useNvidia && cfg.enable) {
    hmConfig = {
      wayland.windowManager.hyprland.settings.env = [
        # "__EGL_VENDOR_LIBRARY_FILENAMES,/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json"
        "WLR_DRM_DEVICES,/home/${username}/.config/hypr/card"
      ];
    };
    osConfig = {
      system.userActivationScripts = {
        hyprlandDrmCard.text = ''
          ln -sf /dev/dri/by-path/${path} /home/${username}/.config/hypr/card
        '';
      };
    };
  };
}
