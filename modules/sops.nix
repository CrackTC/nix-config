{
  sops.defaultSopsFile = ../secrets/common.yaml;
  sops.age.sshKeyPaths = [ ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;
  sops.secrets.nas_credentials = { };
}
