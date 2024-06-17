{ config, lib, ... }:
let cfg = config.waybar; in {
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."tray" = {
      icon-size = 20;
      spacing = 10;
    };
  };
}
