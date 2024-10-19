{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.duf; in {
  options.programs.utility.duf = {
    enable = lib.mkEnableOption "duf";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.duf ];
  };
}
