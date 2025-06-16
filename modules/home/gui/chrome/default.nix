{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.chrome;
in
{
  options.chrome = {
    enable = lib.mkEnableOption "chrome";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = [
      (pkgs.google-chrome.override {
        commandLineArgs =
          if config.wayland.enable then
            (builtins.concatStringsSep " " [
              "--enable-features=UseOzonePlatform"
              "--ozone-platform-hint=wayland"
              "--enable-wayland-ime"
              "--enable-features=AcceleratedVideoDecodeLinuxGL"
            ])
          else
            "";
      })
    ];
  };
}
