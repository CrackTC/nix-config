{ config, lib, ... }:
let
  cfg = config.sorac.host.ssd;
in
{
  options.sorac.host.ssd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Host has SSD";
    };
  };

  config.services.fstrim.enable = lib.mkIf cfg.enable true;
}
