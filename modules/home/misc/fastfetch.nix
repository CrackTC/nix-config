{ config, pkgs, lib, ... }:
let cfg = config.fastfetch; in {
  options.fastfetch = {
    enable = lib.mkEnableOption "fastfetch";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.fastfetch ];
  };
}
