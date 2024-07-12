{ config, pkgs, lib, ... }:
let cfg = config.programs.im.discord; in {
  options.programs.im.discord = {
    enable = lib.mkEnableOption "discord";
  };

  config = lib.mkIf cfg.enable {
    osConfig.assertions = [
      {
        assertion = config.gui.enable;
        message = "discord requires gui.";
      }
    ];
    hmConfig = {
      home.packages = [ pkgs.discord ];
    };
  };
}
