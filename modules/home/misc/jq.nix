{ config, pkgs, lib, ... }:
let cfg = config.jq; in {
  options.jq = {
    enable = lib.mkEnableOption "jq";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.jq ];
  };
}
