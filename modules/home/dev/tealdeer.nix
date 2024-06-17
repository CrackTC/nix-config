{ config, lib, ... }:
let cfg = config.tealdeer; in {
  options.tealdeer = {
    enable = lib.mkEnableOption "tealdeer";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = true;
        };
      };
    };
  };
}
