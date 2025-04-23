{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."hyprland/workspaces" = {
      disable-scroll = true;
      on-click = "activate";
      all-outputs = false;
      format = "<span> {icon} </span>";
      format-icons = {
        "1" = "󱄅";
        "2" = "󰀹";
        "3" = "";
        "4" = "󰞇";
        "5" = "󰇮";
        "6" = "󰂺";
        "7" = "󰎁";
        "8" = "󰍡";
        "9" = "󰓇";
        "10" = "󰈔";
        urgent = "";
        focused = "";
        default = "";
      };
      sort-by-number = true;
    };
  };
}
