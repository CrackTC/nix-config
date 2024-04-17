{ pkgs, ... }: {
  home.packages = with pkgs; [
    man-pages
    man-pages-posix
    gnumake
 
    protobuf

    mars-mips

    minicom

    frida-tools
    ghidra
  ];
}
