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
      pkgs.google-chrome
    ];
  };
}
