{
  config,
  pkgs,
  lib,
  osConfig,
  name,
  ...
}:
let
  cfg = config.podman;
in
{
  options.podman = {
    enable = lib.mkEnableOption "podman";
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      xdg.configFile."containers/policy.json".text = ''
        {
          "default": [
            {
                "type": "insecureAcceptAnything"
            }
          ],
          "transports": {
            "docker-daemon": {
                "": [{"type":"insecureAcceptAnything"}]
            }
          }
        }
      '';

      xdg.configFile."containers/storage.conf".text = ''
        [storage]
        driver = "overlay"
        graphroot = "/home/${name}/.local/share/containers/storage"
        runroot = "/run/user/${toString osConfig.users.users.${name}.uid}/containers/storage"
      '';
    };

    osConfig = {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
        extraPackages = with pkgs; [ podman-compose ];
      };
    };
  };
}
