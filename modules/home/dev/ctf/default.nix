{ config, pkgs, lib, ... }:
let cfg = config.ctf; in {
  imports = [ ./ghidra.nix ];

  options.ctf = {
    enable = lib.mkEnableOption "ctf tools";
  };

  config = lib.mkIf cfg.enable {
    ghidra.enable = true;
    hmConfig = {
      home.packages = with pkgs; [
        nmap
        frida-tools
        metasploit
        netcat-gnu
        jd-gui
        php
      ];
    };
  };
}
