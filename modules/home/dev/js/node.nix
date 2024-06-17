{ config, pkgs, lib, ... }:
let cfg = config.node; in {
  options.node = {
    enable = lib.mkEnableOption "node";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ nodejs ];
  };
}
