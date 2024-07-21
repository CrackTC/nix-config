{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.fastfetch; in {
  options.programs.utility.fastfetch = {
    enable = lib.mkEnableOption "fastfetch";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.fastfetch ];
  };
}
