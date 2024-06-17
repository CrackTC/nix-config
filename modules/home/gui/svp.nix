{ config, pkgs, lib, ... }:
let cfg = config.svp; in {
  options.svp = {
    enable = lib.mkEnableOption "svp";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.svp ];
  };
}
