{ config, lib, ... }:
let cfg = config.imv; in {
  options.imv = {
    enable = lib.mkEnableOption "imv";
  };

  config.hmConfig.programs.imv.enable = cfg.enable;
}
