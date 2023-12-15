{ pkgs, extraRepos, ... }:
let
  display = ">";
  font = "sans-serif bold 20";
in
{
  imports = [
    ./theme.nix
    ./rbw.nix
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      width = 400;
      lines = 20;
      show-icons = true;
      line-margin = 14;
      display-ssh = display;
      display-run = display;
      display-drun = display;
      display-window = display;
      display-combi = display;
    };
    inherit font;
    plugins = [ pkgs.rofi-calc extraRepos.myRepo.rofi-ts ];
  };
}
