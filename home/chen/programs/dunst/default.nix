{ pkgs, ... }: {
  services.dunst = {
    enable = true;
    configFile = ./dunstrc;
  };
  home.packages = with pkgs; [ libnotify ];
}
