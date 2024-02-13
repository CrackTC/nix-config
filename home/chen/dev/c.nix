{ pkgs, ... }: {
  home.packages = with pkgs; [
    cmake
    clang
    gdb
    bear
  ];
}
