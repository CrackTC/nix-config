{ config, lib, ... }:
let
  cfg = config.ssh;
in
{
  options.ssh = {
    enable = lib.mkEnableOption "ssh client";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "Host *" = {
          ForwardAgent = false;
          AddKeysToAgent = "no";
          Compression = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "no";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
        };
        "Host github.com" = {
          HostName = "ssh.github.com";
          Port = 443;
          User = "git";
        };
      };
    };
  };
}
