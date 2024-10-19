{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.btop; in {
  options.programs.utility.btop = {
    enable = lib.mkEnableOption "btop";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.btop ];
  };
}
