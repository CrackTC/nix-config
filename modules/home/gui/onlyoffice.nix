{ config, pkgs, lib, ... }:
let cfg = config.onlyoffice; in {
  options.onlyoffice = {
    enable = lib.mkEnableOption "onlyoffice";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = [ pkgs.onlyoffice-bin ];
  };
}
