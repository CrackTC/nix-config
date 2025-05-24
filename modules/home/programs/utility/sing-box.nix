{
  config,
  name,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.sing-box;
  sing-box = pkgs.sing-box.overrideAttrs rec {
    version = "1.12.0-beta.18";
    src = pkgs.fetchFromGitHub {
      owner = "SagerNet";
      repo = "sing-box";
      rev = "v${version}";
      hash = "sha256-R42+v/1TpnRJrGtftJjee4N+1W5BIK9JEC6UPZerXUw=";
    };
    vendorHash = "sha256-5AWJB5uckIKrYD+r9C7TfYQNBcz1gGkBNIOQelpahXQ=";
    tags = [
      "with_gvisor"
      "with_quic"
      "with_dhcp"
      "with_wireguard"
      "with_utls"
      "with_acme"
      "with_clash_api"
      "with_tailscale"
    ];
  };
in
{
  options.programs.utility.sing-box = {
    enable = lib.mkEnableOption "sing-box";
  };

  config = lib.mkIf cfg.enable {
    osConfig = {
      networking.firewall.checkReversePath = "loose";
      systemd.services.sing-box = {
        description = "fetch config & run sing-box on startup";
        after = [ "network-online.target" ];
        requires = [ "network-online.target" ];
        serviceConfig = {
          ExecStartPre = pkgs.writeShellScript "wait-dns.sh" ''
            until ${pkgs.host}/bin/host example.com; do sleep 1; done
          '';
          ExecStart = pkgs.writeShellScript "sing-box.sh" ''
            ${lib.getExe sing-box} run -D /home/${name}/.config/sing-box
          '';
        };
        wantedBy = [ "multi-user.target" ];
      };
    };
  };
}
