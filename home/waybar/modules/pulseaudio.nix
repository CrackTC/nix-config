{ pkgs, ... }: {
  programs.waybar.settings.mainBar."pulseaudio" = {
    scroll-step = 1;
    format = "<span rise='1100'>{icon} </span>{volume}";
    format-bluetooth = "{icon} {volume}";
    format-bluetooth-muted = " muted";
    format-muted = " muted";
    format-icons = {
      headphone = "󰋋";
      hands-free = "󰂑";
      headset = "󰂑";
      phone = "";
      portable = "";
      car = "";
      default = [ "" "" "" ];
    };
    on-click = "pavucontrol-qt";
  };

  home.packages = with pkgs; [
    lxqt.pavucontrol-qt
  ];
}
