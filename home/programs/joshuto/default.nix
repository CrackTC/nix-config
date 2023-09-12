{ pkgs, ... }: {
  xdg.configFile."joshuto" = {
    source = ./config;
    recursive = true;
  };
  home.packages = with pkgs; [
    joshuto
  ];
}
