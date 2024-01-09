{ info, config, ... }: {
  sops.defaultSopsFile = ../secrets/common.yaml;
  sops.age.sshKeyPaths = [ ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;
  sops.secrets.nas_credentials = { };
  sops.secrets.spotify = {
    mode = "0400";
    owner = config.users.users.${info.username}.name;
    group = config.users.users.${info.username}.group;
  };
  sops.secrets.sub = {
    mode = "0400";
    owner = config.users.users.${info.username}.name;
    group = config.users.users.${info.username}.group;
  };
}
