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
      format = "<span font_weight='normal'>{icon} </span>{capacity}";
      format-charging = "<span font_weight='normal'>󰂄 </span>{capacity}%";
      format-plugged = "<span font_weight='normal'>󰚥 </span>{capacity}%";
      format-alt = "{time} <span font_weight='normal'>{icon}</span>";
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
