{
  programs.waybar.settings.mainBar."temperature" = {
    interval = 1;
    thermal-zone = 1;
    critical-threshold = 80;
    format = "<span font-weight='normal'>{icon}</span>{temperatureC}";
    format-icons = [ " " " " "󰖨 " ];
  };
}
