{
  programs.waybar.settings.mainBar."clock" = {
    timezone = "Asia/Shanghai";
    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    format = "<span rise='800'>󰥔 </span>{:%H:%M:%S}";
    format-alt = "<span rise='800'>󰥔 </span>{:%Y-%m-%d %H:%M:%S}";
    interval = 1;
  };
}
