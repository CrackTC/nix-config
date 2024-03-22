{ info, config, ... }: {
  sops = {
    defaultSopsFile = ../secrets/common.yaml;
    age = {
      sshKeyPaths = [ ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets =
      let
        user = config.users.users.${info.username};
        mode = "0400";
        owner = user.name;
        inherit (user) home;
        inherit (user) group;
      in
      {
        nas_credentials = { };
        spotify = {
          inherit mode owner group;
        };
        sub = {
          inherit mode owner group;
        };
        sub_backup = {
          format = "binary";
          sopsFile = ../secrets/sub_backup.bin;
          inherit mode owner group;
        };
        "mitmproxy-ca.p12" = {
          format = "binary";
          sopsFile = ../secrets/mitmproxy-ca.p12.bin;
          inherit mode owner group;
          path = "${home}/.mitmproxy/mitmproxy-ca.p12";
        };
        "mitmproxy-ca.pem" = {
          format = "binary";
          sopsFile = ../secrets/mitmproxy-ca.pem.bin;
          inherit mode owner group;
          path = "${home}/.mitmproxy/mitmproxy-ca.pem";
        };
        "mitmproxy-dhparam.pem" = {
          format = "binary";
          sopsFile = ../secrets/mitmproxy-dhparam.pem.bin;
          inherit mode owner group;
          path = "${home}/.mitmproxy/mitmproxy-dhparam.pem";
        };
      };
  };
}
