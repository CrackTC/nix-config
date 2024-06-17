{ config, pkgs, lib, ... }:
let cfg = config.discord; in {
  options.discord = {
    enable = lib.mkEnableOption "discord";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.discord ];
  };
}
