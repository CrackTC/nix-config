{ config, pkgs, lib, ... }:
let cfg = config.wpsoffice; in {
  options.wpsoffice = {
    enable = lib.mkEnableOption "wpsoffice";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = [ pkgs.wpsoffice ];
  };
}
