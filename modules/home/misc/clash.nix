{ config, pkgs, lib, ... }:
let cfg = config.clash; in {
  options.clash = {
    enable = lib.mkEnableOption "clash";
  };

  config = lib.mkIf cfg.enable {
    osConfig = {
      systemd.services.clash = {
        description = "fetch sub and run clash on startup";
        after = [ "network-online.target" ];
        requires = [ "network-online.target" ];
        serviceConfig = {
          ExecStart = pkgs.writeScript "clash.fish" ''
            #!${pkgs.fish}/bin/fish
            set config ~/.config/clash/config.yaml
            if not test -e $config
              set sub (cat /run/secrets/sub)
              set -e (env | grep proxy | cut -d= -f1)
              if ${pkgs.curl}/bin/curl -o $config $sub
                cat $config |
                  grep -v '^port' |
                  grep -v '^socks-port' |
                  grep -v '^mixed-port' |
                  grep -v '^mode' > $config.tmp
                echo 'mixed-port: 7890' >> $config.tmp
                echo 'mode: direct' >> $config.tmp
                mv $config.tmp $config
              else
                echo "failed to fetch sub, using default config"
                cat /run/secrets/sub_backup | base64 -d > $config
              end
            end
            ${pkgs.clash-meta}/bin/clash-meta -f $config
          '';
        };
        wantedBy = [ "multi-user.target" ];
      };

      networking.proxy = {
        default = "http://127.0.0.1:7890";
        noProxy = "127.0.0.1,localhost,internal.domain";
      };
    };
  };
}
