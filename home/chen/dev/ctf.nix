{ pkgs, ... }: {
  home.packages = with pkgs; [
    nmap
    frida-tools
    metasploit
    ghidra
    netcat-gnu
    jd-gui
    php
  ];
}
