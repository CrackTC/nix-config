{ config, lib, ... }:
let cfg = config.ssh; in {
  options.ssh = {
    enable = lib.mkEnableOption "ssh client";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.ssh.enable = true;
    programs.ssh.extraConfig = ''
      Host github.com
          Hostname ssh.github.com
          Port 443
          User git
    '';
  };
}
