{
  programs.waybar.settings.mainBar."battery" = {
    states = {
      warning = 30;
      critical = 15;
    };
    format = "<span rise=\"800\">{icon} </span>{capacity}";
    format-charging = "󰂄 {capacity}%";
    format-plugged = "󰚥 {capacity}%";
    format-alt = "{time} {icon}";
    format-full = "<span rise='-18000'></span>";
    format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
  };
}
