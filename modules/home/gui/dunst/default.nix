{ config, pkgs, lib, ... }:
let cfg = config.dunst; in {
  options.dunst = {
    enable = lib.mkEnableOption "dunst";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    services.dunst = {
      enable = true;
      configFile = ./dunstrc;
    };
    home.packages = with pkgs; [ libnotify ];
  };
}
