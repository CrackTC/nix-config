{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."temperature" = {
      interval = 1;
      thermal-zone = 1;
      critical-threshold = 80;
      format = "<span font_weight='normal'>{icon}</span>{temperatureC}";
      format-icons = [
        " "
        " "
        "󰖨 "
      ];
    };
  };
}
