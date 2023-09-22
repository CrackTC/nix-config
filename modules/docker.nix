{ info, ... }: {
  virtualisation.docker.enable = true;
  users.users.${info.username}.extraGroups = [ "docker" ];
}
