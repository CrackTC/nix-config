{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.media.cider;
in
{
  options.programs.media.cider = {
    enable = lib.mkEnableOption "cider";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [ pkgs.cider-2 ];
    };
  };
}
