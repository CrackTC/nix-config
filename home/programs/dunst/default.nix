{ pkgs, ... }: {
  xdg.configFile."dunst" = {
    source = ./config;
    recursive = true;
  };
  home.packages = with pkgs; [ dunst ];
}
