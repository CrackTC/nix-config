{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.showmethekey;
in
{
  options.showmethekey = {
    enable = lib.mkEnableOption "showmethekey";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = with pkgs; [ showmethekey ];
  };
}
