{ config, lib, ... }:
let cfg = config.waybar; in {
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."hyprland/workspaces" = {
      disable-scroll = true;
      on-click = "activate";
      all-outputs = false;
      format = "{icon}";
      format-icons = {
        "1" = "<span> 󱄅 </span>";
        "2" = "<span> 󰀹 </span>";
        "3" = "<span>  </span>";
        "4" = "<span> 󰞇 </span>";
        "5" = "<span> 󰇮 </span>";
        "6" = "<span> 󰂺 </span>";
        "7" = "<span> 󰎁 </span>";
        "8" = "<span> 󰍡 </span>";
        "9" = "<span> 󰓇 </span>";
        "10" = "<span> 󰈔 </span>";
        urgent = "";
        focused = "";
        default = "";
      };
      sort-by-number = true;
    };
  };
}
