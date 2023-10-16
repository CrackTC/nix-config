{ lib, ... }: {
  wayland.windowManager.hyprland.settings = {
    monitor = lib.mkForce [
      "eDP-1,2560x1440@240,0x0,1"
    ];

    workspace = lib.mkForce [ ];
  };
}
