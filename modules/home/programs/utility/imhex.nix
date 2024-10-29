{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.imhex; in {
  options.programs.utility.imhex = {
    enable = lib.mkEnableOption "imhex";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.imhex ];
  };
}
