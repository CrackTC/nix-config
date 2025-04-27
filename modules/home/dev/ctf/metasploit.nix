{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.metasploit;
in
{
  options.metasploit = {
    enable = lib.mkEnableOption "metasploit";
  };

  config = lib.mkIf cfg.enable {
    hmConfig.home.packages = [ pkgs.metasploit ];
  };
}
