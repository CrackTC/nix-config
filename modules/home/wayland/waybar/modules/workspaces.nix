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
        "0-background" = "󰈔";
        "1-terminal" = "󱄅";
        "2-web" = "󰀹";
        "3-notes" = "";
        "4-burp" = "󰞇";
        "5-mail" = "󰇮";
        "6-book" = "󰂺";
        "7-movie" = "󰎁";
        "8-chat" = "󰍡";
        "9-music" = "󰓇";
        urgent = "";
        focused = "";
        default = "";
      };
      sort-by-number = true;
    };
  };
}
