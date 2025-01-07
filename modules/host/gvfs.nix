{ config, lib, ... }:
{
  options.sorac.host.gvfs = {
    enable = lib.mkEnableOption "gvfs";
  };
  config.services.gvfs.enable = lib.mkIf config.sorac.host.gvfs.enable true;
}
