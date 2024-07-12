{ config, pkgs, lib, ... }:
let cfg = config.programs.im.telegram; in {
  options.programs.im.telegram = {
    enable = lib.mkEnableOption "telegram";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [ pkgs.telegram-desktop ];
    };
  };
}
