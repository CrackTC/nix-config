{
  programs.waybar.settings.mainBar."temperature" = {
    interval = 1;
    thermal-zone = 1;
    critical-threshold = 80;
    format = "{icon} {temperatureC}";
    format-icons = [ "" "" "󰖨" ];
  };
}
