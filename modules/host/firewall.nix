{ config, lib, ... }:
let
  cfg = config.sorac.host;
in
{
  options.sorac.host.firewallCommonPorts = lib.mkEnableOption "firewall common ports";
  config.networking.firewall = lib.mkIf cfg.firewallCommonPorts {
    enable = true;
    allowedTCPPorts = [
      22
      80
      443
    ];
    allowedUDPPorts = [ 53 ];
    allowedTCPPortRanges = [
      {
        from = 1024;
        to = 65535;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1024;
        to = 65535;
      }
    ];
  };
}
