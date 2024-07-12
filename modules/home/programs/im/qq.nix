{ config, pkgs, lib, ... }:
let cfg = config.programs.im.qq; in {
  options.programs.im.qq = {
    enable = lib.mkEnableOption "qq";
  };

  config = lib.mkIf cfg.enable {
    osConfig.assertions = [
      {
        assertion = config.gui.enable;
        message = "qq requires gui.";
      }
    ];
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
