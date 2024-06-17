{ config, pkgs, lib, ... }:
let cfg = config.bc; in {
  options.bc = {
    enable = lib.mkEnableOption "bc";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.bc ];
  };
}
