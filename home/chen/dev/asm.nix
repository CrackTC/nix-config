{ pkgs, ... }: {
  home.packages = with pkgs; [
    bochs
    nasm
  ];
}
