{ pkgs, ... }: {
  home.packages = with pkgs; [
    python3
    conda
    yapf
  ];
}
