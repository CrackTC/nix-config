{ config, pkgs, lib, ... }:
let cfg = config.detect-it-easy; in {
  options.detect-it-easy = {
    enable = lib.mkEnableOption "detect-it-easy";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.detect-it-easy ];
  };
}
