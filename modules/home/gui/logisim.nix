{ config, pkgs, lib, ... }:
let cfg = config.logisim; in {
  options.logisim = {
    enable = lib.mkEnableOption "logisim";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = with pkgs; [ logisim-evolution ];
  };
}
