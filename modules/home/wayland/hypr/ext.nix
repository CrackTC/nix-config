{ config, lib, hostConfig, ... }:
let
  cfg = config.hypr;
  mkMonitorStr = monitor:
    "${monitor.name},${toString monitor.weight}x${toString monitor.height}@${toString monitor.refresh},${toString monitor.left}x${toString monitor.top},${toString monitor.scale}";
  inherit (hostConfig) monitors;
in
{
  options.hypr = {
    extMonitor = lib.mkEnableOption "external monitor";
  };
  config.hmConfig = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = lib.mkMerge [
      (lib.mkIf (!cfg.extMonitor && builtins.length monitors > 0) {
        # monitor = lib.mkForce [ "eDP-1,2560x1440@240,0x0,1" ];
        monitor = mkMonitorStr (builtins.head monitors);
        workspace = lib.mkForce [ ];
      })
      (lib.mkIf (cfg.extMonitor && builtins.length monitors > 1) {
        # monitor = lib.mkDefault [ "DP-1,2560x1440@170,auto,1.25" "eDP-1,2560x1440@240,0x0,1.25" ];
        monitor = map mkMonitorStr monitors;

        workspace =
          let
            defaultMonitor = (builtins.elemAt monitors 1).name;
            secondaryMonitor = (builtins.head monitors).name;
          in
          [
            "1, monitor:${defaultMonitor}"
            "2, monitor:${defaultMonitor}"
            "3, monitor:${defaultMonitor}"
            "4, monitor:${defaultMonitor}"
            "5, monitor:${defaultMonitor}"
            "6, monitor:${defaultMonitor}"
            "7, monitor:${defaultMonitor}"
            "8, monitor:${defaultMonitor}"
            "9, monitor:${secondaryMonitor}"
            "10, monitor:${secondaryMonitor}, default:true"
          ];
      })
    ];
  };
}
