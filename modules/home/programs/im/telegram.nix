{ config, pkgs, lib, ... }:
let cfg = config.programs.im.telegram; in {
  options.programs.im.telegram = {
    enable = lib.mkEnableOption "telegram";
  };

  config = lib.mkIf cfg.enable {
    osConfig.assertions = [
      {
        assertion = config.gui.enable;
        message = "telegram requires gui.";
      }
    ];
    hmConfig = {
      home.packages = [ pkgs.telegram-desktop ];
    };
  };
}
