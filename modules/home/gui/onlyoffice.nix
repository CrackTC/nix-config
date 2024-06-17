{ config, pkgs, lib, ... }:
let cfg = config.onlyoffice; in {
  options.onlyoffice = {
    enable = lib.mkEnableOption "onlyoffice";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.onlyoffice-bin ];
  };
}
