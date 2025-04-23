{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    services.playerctld.enable = true;
    programs.waybar.settings.mainBar."mpris" = {
      interval = 1;
      format = "<span font_weight='normal' rise='1pt'>{player_icon}</span>  {dynamic}";
      format-paused = "<span font_weight='normal' rise='1pt'>{status_icon}</span>  {dynamic}";
      player-icons = {
        default = "";
        spotify = "";
        mpv = "";
      };
      status-icons = {
        playing = "";
        paused = "";
        stopped = "";
      };
    };
  };
}
