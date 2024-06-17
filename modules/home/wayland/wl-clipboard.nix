{ config, pkgs, lib, ... }:
let cfg = config.wl-clipboard; in {
  options.wl-clipboard = {
    enable = lib.mkEnableOption "wl-clipboard";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ wl-clipboard ];
  };
}
