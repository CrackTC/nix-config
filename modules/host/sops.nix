{
  sops = {
    defaultSopsFile = ../../secrets/common.yaml;
    age = {
      sshKeyPaths = [ ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = let mode = "0400"; in {
      nas_credentials = { };
      spotify = {
        inherit mode;
        owner = "chen";
        group = "users";
      };
      sub = {
        inherit mode;
        owner = "chen";
        group = "users";
      };
      sub_backup = {
        format = "binary";
        sopsFile = ../../secrets/sub_backup.bin;
        inherit mode;
        owner = "chen";
        group = "users";
      };
      "mitmproxy-ca.p12" = {
        format = "binary";
        sopsFile = ../../secrets/mitmproxy-ca.p12.bin;
        inherit mode;
        owner = "chen";
        group = "users";
        path = "/home/chen/.mitmproxy/mitmproxy-ca.p12";
      };
      "mitmproxy-ca.pem" = {
        format = "binary";
        sopsFile = ../../secrets/mitmproxy-ca.pem.bin;
        inherit mode;
        owner = "chen";
        group = "users";
        path = "/home/chen/.mitmproxy/mitmproxy-ca.pem";
      };
      "mitmproxy-dhparam.pem" = {
        format = "binary";
        sopsFile = ../../secrets/mitmproxy-dhparam.pem.bin;
        inherit mode;
        owner = "chen";
        group = "users";
        path = "/home/chen/.mitmproxy/mitmproxy-dhparam.pem";
      };
    };
  };
}
