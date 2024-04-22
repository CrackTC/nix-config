{ pkgs, ... }: {
  home.packages = with pkgs; [
    man-pages
    man-pages-posix
    gnumake
 
    protobuf

    mars-mips

    minicom

    metasploit
    nmap
    netcat-gnu
    frida-tools
    ghidra

    godot_4
  ];
}
