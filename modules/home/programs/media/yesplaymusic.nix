{ config, pkgs, lib, ... }:
let cfg = config.programs.media.yesplaymusic; in {
  options.programs.media.yesplaymusic = {
    enable = lib.mkEnableOption "yesplaymusic";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = with pkgs; [ yesplaymusic ];
    };
  };
}
