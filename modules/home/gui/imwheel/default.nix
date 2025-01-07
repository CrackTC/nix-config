{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.imwheel;
in
{
  options.imwheel = {
    enable = lib.mkEnableOption "imwheel";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.file.".imwheelrc".source = ./.imwheelrc;
    home.packages = with pkgs; [ imwheel ];
  };
}
