{ pkgs, ... }: {
  home.packages = with pkgs; [
    cmake
    clang
    gdb
    bear
    valgrind # for memory profiling
  ];
}
