{ pkgs, ... }:
{
  systemd.services.clash = {
    description = "fetch sub and run clash on startup";
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = pkgs.writeScript "clash.fish" ''
        #!${pkgs.fish}/bin/fish
        set config ~/.config/clash/config.yaml
        if not test -e $config
          set sub (cat /run/secrets/sub)
          set -e (env | grep proxy | cut -d= -f1)
          ${pkgs.curl}/bin/curl -o $config $sub
          cat $config |
            grep -v '^port' |
            grep -v '^socks-port' |
            grep -v '^mixed-port' |
            grep -v '^mode' > $config.tmp
          echo 'mixed-port: 7890' >> $config.tmp
          echo 'mode: direct' >> $config.tmp
          mv $config.tmp $config
        end
        ${pkgs.clash-meta}/bin/clash-meta -f $config
      '';
    };
    wantedBy = [ "multi-user.target" ];
  };
}
