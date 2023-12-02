{ pkgs, ... }: {
  home.packages = with pkgs; [
    lhs2tex
    texlive.combined.scheme-full
  ];
}
