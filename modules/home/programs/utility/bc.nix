{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.bc; in {
  options.programs.utility.bc = {
    enable = lib.mkEnableOption "bc";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.bc ];
  };
}
