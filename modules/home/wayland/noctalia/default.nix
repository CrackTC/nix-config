{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.noctalia;
in
{
  options.noctalia = {
    enable = lib.mkEnableOption "noctalia";
  };

  config = lib.mkIf cfg.enable {
    wayland.enable = true;
    hmConfig = {
    };
  };
}
