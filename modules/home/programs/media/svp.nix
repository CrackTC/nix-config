{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.media.svp;
in
{
  options.programs.media.svp = {
    enable = lib.mkEnableOption "svp";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = [ pkgs.svp ];
  };
}
