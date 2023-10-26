{ info, ... }: {
  virtualisation.docker.enable = true;
  users.users.${info.username}.extraGroups = [ "docker" ];
  environment.etc = {
    "docker/daemon.json" = {
      text = ''
      {
        "registry-mirrors": [ "https://docker.mirrors.ustc.edu.cn/" ]
      }
      '';
    };
  };
}
