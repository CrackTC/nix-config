{ config, lib, ... }:
let
  cfg = config.programs.utility.waydroid;
in
{
  options.programs.utility.waydroid = {
    enable = lib.mkEnableOption "waydroid";
  };

  config.osConfig = lib.mkIf cfg.enable {
    virtualisation.waydroid.enable = true;
  };
}
