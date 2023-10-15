{ lib, ... }: {
  wayland.windowManager.hyprland.settings.monitor = lib.mkForce [
    "DP-2,2560x1440@170,0x0,1"
    "eDP-1,2560x1440@240,2560x0,1"
    "monitor=HDMI-A-1,disabled"
  ];
}
