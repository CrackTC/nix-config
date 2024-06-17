{ config, pkgs, lib, ... }:
let cfg = config.osu; in {
  options.osu = {
    enable = lib.mkEnableOption "osu";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ osu-lazer-bin ];
  };
}
