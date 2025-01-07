{ config, lib, ... }:
let
  cfg = config.sorac.host.ssh;
in
{
  options.sorac.host.ssh = {
    enable = lib.mkEnableOption "ssh server";
  };
  config.services.openssh.enable = cfg.enable;
}
