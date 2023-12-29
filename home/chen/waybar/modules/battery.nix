{
  programs.waybar.settings.mainBar."battery" = {
    states = {
      warning = 30;
      critical = 15;
    };
    format = "<span font-weight='normal'>{icon} </span>{capacity}";
    format-charging = "<span font-weight='normal'>󰂄 </span>{capacity}%";
    format-plugged = "<span font-weight='normal'>󰚥 </span>{capacity}%";
    format-alt = "{time} <span font-weight='normal'>{icon}</span>";
    format-full = "<span font-weight='normal'></span>";
    format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
  };
}
