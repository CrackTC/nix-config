{ config, pkgs, lib, ... }:
let cfg = config.scheme; in {
  options.scheme = {
    enable = lib.mkEnableOption "scheme";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ mitscheme ];
  };
}
