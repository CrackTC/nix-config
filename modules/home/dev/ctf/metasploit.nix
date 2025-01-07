{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.metasploit;
  metasploit = pkgs.metasploit.overrideAttrs {
    version = "unstable-24-07-20";
    src = pkgs.fetchFromGitHub {
      owner = "rapid7";
      repo = "metasploit-framework";
      rev = "db5ace8c5f839d7471fd503a1758e65105502cd8";
      hash = "sha256-BA83dSAUkqINdGV2JqLhdC0d7QIUz/iNCrjv080zYMQ=";
    };
  };
in
{
  options.metasploit = {
    enable = lib.mkEnableOption "metasploit";
  };

  config = lib.mkIf cfg.enable {
    hmConfig.home.packages = [ metasploit ];
  };
}
