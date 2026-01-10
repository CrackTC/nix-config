{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.programs.media.vlc;
in
{
  options.programs.media.vlc = {
    enable = lib.mkEnableOption "vlc";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = [ pkgs.vlc ];
  };
}
