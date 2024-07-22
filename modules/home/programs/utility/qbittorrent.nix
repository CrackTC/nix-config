{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.qbittorrent; in {
  options.programs.utility.qbittorrent = {
    enable = lib.mkEnableOption "qbittorrent";
  };

  config = lib.mkIf cfg.enable {
    hmConfig.home.packages = [ pkgs.qbittorrent ];
  };
}
