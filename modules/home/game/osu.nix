{ config, pkgs, lib, ... }:
let cfg = config.game.osu; in {
  options.game.osu = {
    enable = lib.mkEnableOption "osu";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ osu-lazer-bin ];
  };
}
