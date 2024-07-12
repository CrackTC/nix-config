{ config, pkgs, lib, ... }:
let cfg = config.programs.media.yesplaymusic; in {
  options.programs.media.yesplaymusic = {
    enable = lib.mkEnableOption "yesplaymusic";
  };

  config = lib.mkIf cfg.enable {
    osConfig.assertions = [
      {
        assertion = config.gui.enable;
        message = "yesplaymusic requires gui.";
      }
    ];
    hmConfig = {
      home.packages = with pkgs; [ yesplaymusic ];
    };
  };
}
