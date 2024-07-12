{ config, pkgs, lib, ... }:
let cfg = config.programs.im.qq; in {
  options.programs.im.qq = {
    enable = lib.mkEnableOption "qq";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [
        (pkgs.qq.override {
          commandLineArgs =
            if config.wayland.enable
            then "--ozone-platform-hint=auto --enable-wayland-ime --gtk-version=4"
            else "";
        })
      ];
    };
  };
}
