{
  programs.waybar.settings.mainBar."wlr/workspaces" = {
    disable-scroll = true;
    on-click = "activate";
    all-outputs = true;
    format = "{icon}";
    format-icons = {
      "1" = "<span size='1000'> </span><span size='small'></span>";
      "2" = "<span rise='-18500'>󰈹</span>";
      "3" = "<span size='13000'></span>";
      "4" = "<span size='14000' rise='-17000'>󰞇</span>";
      "5" = "<span rise='-16000'>󰇮</span>";
      "6" = "<span size='14000'>󰂺</span>";
      "7" = "<span rise='-18000'>󱖏</span>";
      "8" = "<span size='14000' rise='-17800'>󰍡</span>";
      "9" = "<span size='14000' rise='-16000'></span>";
      "10" = "<span size='12000' rise='-7000'></span>";
      urgent = "";
      focused = "";
      default = "";
    };
  };
}
