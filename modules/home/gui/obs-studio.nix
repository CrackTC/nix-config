{ config, lib, ... }:
let cfg = config.obs-studio; in {
  options.obs-studio = {
    enable = lib.mkEnableOption "obs-studio";
  };

  config.hmConfig.programs.obs-studio.enable = lib.mkIf (config.gui.available && cfg.enable) true;
}
