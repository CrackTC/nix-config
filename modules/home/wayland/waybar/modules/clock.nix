{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."clock" = {
      timezone = "Asia/Shanghai";
      format = "<span font_weight='normal'>󰥔 </span>{:%H:%M:%S}";
      interval = 1;
      format-alt = "<span font_weight='normal'>󰥔 </span>{:%A, %B %d, %Y (%H:%M:%S)}";
      tooltip-format = "<span size='9pt' font_family='Noto Sans Mono CJK SC'>{calendar}</span>";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        on-click-right = "mode";
        format = {
          months = "<span color='#ebcb8b'><b>{}</b></span>";
          days = "<span color='#b48ead'><b>{}</b></span>";
          weeks = "<span color='#a3be8c'><b>W{}</b></span>";
          weekdays = "<span color='#d08770'><b>{}</b></span>";
          today = "<span color='#bf616a'><b><u>{}</u></b></span>";
        };
      };
    };
  };
}
