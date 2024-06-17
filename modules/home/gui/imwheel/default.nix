{ config, pkgs, lib, ... }:
let cfg = config.imwheel; in {
  options.imwheel = {
    enable = lib.mkEnableOption "imwheel";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.file.".imwheelrc".source = ./.imwheelrc;
    home.packages = with pkgs; [ imwheel ];
  };
}
