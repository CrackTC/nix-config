{
  config,
  pkgs,
  lib,
  name,
  inputs,
  system,
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
      home.packages = [
        inputs.nixpkgs-master.legacyPackages.${system}.mitmproxy
        pkgs.rlwrap
        pkgs.websocat
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
