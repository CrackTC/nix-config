{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 3000 3001 3002 3003 3004 3005 3006 3007 3008 3009 3010 ];
    allowedUDPPorts = [ 53 ];
    allowedTCPPortRanges = [ { from = 1024; to = 65535; } ];
    allowedUDPPortRanges = [ { from = 1024; to = 65535; } ];
  };
}
