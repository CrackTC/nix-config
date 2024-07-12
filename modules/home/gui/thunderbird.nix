{config, pkgs, lib, ...}:
let cfg = config.thunderbird; in {
  options.thunderbird = {
    enable = lib.mkEnableOption "thunderbird";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = [ pkgs.thunderbird ];
  };
}
