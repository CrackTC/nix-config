{ pkgs, ... }: {
  xdg.configFile."joshuto" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
    joshuto
    file
  ];

  programs = {
    pandoc.enable = true;
    bat = {
      enable = true;
      config.theme = "Nord";
    };
  };
}
