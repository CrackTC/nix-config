{ config, lib, ... }:
let
  cfg = config.sorac.host;
in
{
  options.sorac.host.name = lib.mkOption {
    type = lib.types.str;
    description = "The name of the host";
  };
  config.networking.hostName = cfg.name;
}
