{ lib, ... }: {
  wayland.windowManager.hyprland.settings.monitor = lib.mkForce [
    "DP-1,disabled"
    "eDP-1,2560x1440@240,0x0,1"
    "monitor=HDMI-A-1,disabled"
  ];
}
