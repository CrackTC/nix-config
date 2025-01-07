{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.man;
in
{
  options.man = {
    enable = lib.mkEnableOption "man-pages";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      man-pages
      man-pages-posix
    ];
  };
}
