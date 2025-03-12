{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.ctf;
in
{
  imports = [
    ./detect-it-easy.nix
    ./ghidra.nix
    ./metasploit.nix
  ];

  options.ctf = {
    enable = lib.mkEnableOption "ctf tools";
  };

  config = lib.mkIf cfg.enable {
    detect-it-easy.enable = true;
    ghidra.enable = true;
    metasploit.enable = true;
    hmConfig = {
      home.packages = with pkgs; [
        nmap
        frida-tools
        netcat-openbsd
        bytecode-viewer
        php
        sqlmap
        hurl
      ];
    };
  };
}
