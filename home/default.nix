{ pkgs, inputs, ... }:
let
  nur = import inputs.nur {
    nurpkgs = pkgs;
    pkgs = pkgs;
  };
  useNvidia = false;
  extMonitor = true;
in
{
  imports = [
    (import ./programs nur)
    (import ./hypr { inherit useNvidia; inherit extMonitor; })
    ./dev
    ./fcitx5
    ./mime
    ./rofi
    ./shell
    ./theme
    ./waybar
  ];

  home.username = "chen";
  home.homeDirectory = "/home/chen";

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
