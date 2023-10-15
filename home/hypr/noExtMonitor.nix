{ lib, ... }: {
  wayland.windowManager.hyprland.settings = {
    monitor = lib.mkForce [
      "DP-2,2560x1440@170,0x0,1"
      "eDP-1,2560x1440@240,2560x0,1"
      "monitor=HDMI-A-1,disabled"
    ];
    workspace = [
      "1, monitor:eDP-1"
      "2, monitor:eDP-1"
      "3, monitor:eDP-1"
      "4, monitor:eDP-1"
      "5, monitor:eDP-1"
      "6, monitor:eDP-1"
      "7, monitor:eDP-1"
      "8, monitor:eDP-1"
      "9, monitor:DP-2"
      "10, monitor:DP-2, default:true"
    ];
  };
}
