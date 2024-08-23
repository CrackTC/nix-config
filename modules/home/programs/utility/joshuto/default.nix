{ config, lib, pkgs, ... }:
let cfg = config.programs.utility.joshuto; in {
  options.programs.utility.joshuto = {
    enable = lib.mkEnableOption "joshuto";
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      xdg.configFile."joshuto" = {
        source = ./config;
        recursive = true;
      };

      home.packages = [ pkgs.joshuto pkgs.file ];
    };

    programs.utility = {
      bat.enable = true;
      pandoc.enable = true;
    };
  };
}
