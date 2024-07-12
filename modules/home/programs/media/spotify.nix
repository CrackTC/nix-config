{ config, pkgs, lib, ... }:
let cfg = config.programs.media.spotify; in {
  options.programs.media.spotify = {
    enable = lib.mkEnableOption "spotify";
  };

  config = lib.mkIf cfg.enable {
    osConfig.assertions = [
      {
        assertion = config.gui.enable;
        message = "spotify requires gui.";
      }
    ];
    hmConfig = {
      home.packages = with pkgs; [ spotify ];
    };
  };
}
