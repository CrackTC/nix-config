{pkgs, ...}: {
  home.packages = with pkgs; [
    verilog
    gtkwave
  ];
}
