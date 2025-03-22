let
  listenPort = 51820;
in
{
  config = {
    sops.secrets.wireguard_private_key = { };
    networking = {
      firewall.allowedUDPPorts = [ listenPort ];
      wireguard = {
        enable = true;
        interfaces = {
          wg0 = {
            ips = [ "192.168.96.100/24" ];
            inherit listenPort;
            privateKeyFile = "/run/secrets/wireguard_private_key";

            peers = [
              {
                publicKey = "e/KvjAa+7mQt+RgC1+cSQMiWipaVu8d/hIbrgVT/uDY=";
                allowedIPs = [ "192.168.96.0/24" ];
                endpoint = "nas.sora.zip:39353";
              }
            ];
          };
        };
      };
    };
  };
}

