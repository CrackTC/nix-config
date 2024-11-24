{ config, pkgs, lib, ... }:
let cfg = config.programs.media.songrec; in {
  options.programs.media.songrec = {
    enable = lib.mkEnableOption "songrec";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [ pkgs.songrec ];
    };
  };
}
