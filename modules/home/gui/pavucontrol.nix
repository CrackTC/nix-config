{ config, pkgs, lib, ... }:
let cfg = config.pavucontrol; in {
  options.pavucontrol = {
    enable = lib.mkEnableOption "pavucontrol";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = with pkgs; [ pavucontrol ];
  };
}
