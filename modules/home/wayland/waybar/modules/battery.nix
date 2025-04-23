{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."battery" = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "<span font_weight='normal' rise='1pt'>{icon} </span>{capacity}";
      format-charging = "<span font_weight='normal' rise='1pt'>󰂄 </span>{capacity}%";
      format-plugged = "<span font_weight='normal' rise='1pt'>󰚥 </span>{capacity}%";
      format-alt = "<span font_weight='normal' rise='1pt'>{icon}</span> {time}";
      format-full = "<span font_weight='normal'>  </span>";
      format-icons = [
        "󰁺"
        "󰁼"
        "󰁾"
        "󰂀"
        "󰁹"
      ];
    };
  };
}
