{ pkgs, ... }: {
  home.packages = with pkgs; [
    clang
    gdb
    bear
  ];
}
