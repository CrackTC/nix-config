{ config, lib, ... }:
let
  cfg = config.sorac.host.wacom;
in
{
  options.sorac.host.wacom = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Host has a wacom tablet";
    };
  };
  config.hardware.opentabletdriver.enable = lib.mkIf cfg.enable true;
}
