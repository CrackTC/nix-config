{ config, pkgs, lib, ... }:
let cfg = config.rider; in {
  options.rider = {
    enable = lib.mkEnableOption "rider";
  };

  config = lib.mkIf cfg.enable {
    jetbrains.enable = true;
    hmConfig = {
      home.packages = [ pkgs.jetbrains.rider ];
    };
  };
}
