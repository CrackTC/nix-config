{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."cpu" = {
      interval = 1;
      format = "<span font_weight='normal' rise='1pt'>󰍛 </span>{usage:>2}";
      tooltip = true;
    };
  };
}
