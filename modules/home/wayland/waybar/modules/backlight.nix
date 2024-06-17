{ config, lib, ... }:
let cfg = config.waybar; in {
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."backlight" = {
      format = "<span font-weight='normal'>{icon} </span>{percent}";
      format-icons = [ "" "" "" "" "" "" "" "" "" ];
    };
  };
}
