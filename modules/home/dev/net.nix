{
  config,
  pkgs,
  extraRepos,
  lib,
  name,
  ...
}:
let
  cfg = config.net;
in
{
  options.net = {
    enable = lib.mkEnableOption "network utils";
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      home.packages = with pkgs; [
        extraRepos.pkgs-master.mitmproxy
        rlwrap
        websocat
      ];

      home.file.".mitmproxy" = {
        source = ./mitm;
        recursive = true;
      };
    };

    osConfig = {
      security.pki.certificateFiles = [ ./mitm/mitmproxy-ca-cert.pem ];
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
      };

      users.users.${name}.extraGroups = [ "wireshark" ];
    };
  };
}
