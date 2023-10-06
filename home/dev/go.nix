{ pkgs, ... }: {
  programs.go = {
    enable = true;
    package = pkgs.go_1_21;
    goPath = "proj/go";
  };
}
