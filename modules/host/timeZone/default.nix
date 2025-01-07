{ config, lib, ... }:
let
  cfg = config.sorac.host;
in
{
  options.sorac.host.timeZone = lib.mkOption {
    type = lib.types.str;
    default = "Asia/Shanghai";
    description = "Host time zone";
  };

  config.time.timeZone = cfg.timeZone;
}
