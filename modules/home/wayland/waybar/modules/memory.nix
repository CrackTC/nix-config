{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."memory" = {
      format = "<span font_weight='normal' rise='1pt'>󰏖 </span>{}";
    };
  };
}
