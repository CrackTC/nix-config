{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.waybar;
in
{
  config = lib.mkIf cfg.enable {
    pavucontrol.enable = true;
    hmConfig = {
      programs.waybar.settings.mainBar."pulseaudio" = {
        scroll-step = 1;
        format = "<span font-weight='normal'>{icon} </span>{volume}";
        format-bluetooth = "{icon} {volume}";
        format-bluetooth-muted = " muted";
        format-muted = " muted";
        format-icons = {
          headphone = "󰋋";
          hands-free = "󰂰";
          headset = "󰂰";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
            ""
          ];
        };
        on-click = "pavucontrol";
      };
    };
  };
}
