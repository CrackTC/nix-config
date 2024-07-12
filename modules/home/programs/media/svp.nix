{ config, pkgs, lib, ... }:
let cfg = config.programs.media.svp; in {
  options.programs.media.svp = {
    enable = lib.mkEnableOption "svp";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.svp ];
  };
}
