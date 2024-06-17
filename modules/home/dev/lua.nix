{ config, lib, ... }:
let cfg = config.lua; in {
  options.lua = {
    enable = lib.mkEnableOption "lua";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ ];
  };
}
