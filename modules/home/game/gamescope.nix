{ config, pkgs, lib, ... }:
let cfg = config.gamescope; in {
  options.gamescope = {
    enable = lib.mkEnableOption "gamescope";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ gamescope ];
  };
}
