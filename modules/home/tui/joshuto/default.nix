{ config, lib, pkgs, ... }:
let cfg = config.joshuto; in {
  options.joshuto = {
    enable = lib.mkEnableOption "joshuto";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    xdg.configFile."joshuto" = {
      source = ./config;
      recursive = true;
    };

    home.packages = [ pkgs.joshuto pkgs.file ];

    programs = {
      pandoc.enable = true;
      bat = {
        enable = true;
        config.theme = "Nord";
      };
    };
  };
}
