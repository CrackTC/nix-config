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
      matchBlocks = {
        "*" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };

        "github.com" = {
          port = 443;
          hostname = "ssh.github.com";
          user = "git";
        };
      };
    };
  };
}
