{ config, pkgs, lib, ... }:
let cfg = config.programs.im.discord; in {
  options.programs.im.discord = {
    enable = lib.mkEnableOption "discord";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [ pkgs.discord ];
    };
  };
}
