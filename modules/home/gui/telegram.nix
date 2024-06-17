{ config, pkgs, lib, ... }:
let cfg = config.telegram; in {
  options.telegram = {
    enable = lib.mkEnableOption "telegram";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.telegram-desktop ];
  };
}
