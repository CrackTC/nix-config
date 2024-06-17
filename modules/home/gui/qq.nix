{ config, pkgs, lib, ... }:
let cfg = config.qq; in {
  options.qq = {
    enable = lib.mkEnableOption "qq";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.qq.override {
        commandLineArgs =
          if config.wayland.enable
          then "--ozone-platform-hint=auto --enable-wayland-ime --gtk-version=4"
          else "";
      })
    ];
  };
}
