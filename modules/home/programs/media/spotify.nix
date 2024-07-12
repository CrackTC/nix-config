{ config, pkgs, lib, ... }:
let cfg = config.programs.media.spotify; in {
  options.programs.media.spotify = {
    enable = lib.mkEnableOption "spotify";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = with pkgs; [ spotify ];
    };
  };
}
