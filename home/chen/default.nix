{ info, ... }:
let
  useNvidia = false;
  extMonitor = true;
in
{
  imports = [
    (import ./hypr { inherit useNvidia; inherit extMonitor; })
    ./dev
    ./game
    ./programs
    ./rofi
    ./shell
    ./theme
    ./wallpaper.nix
    ./waybar
    ./xdg
  ];

  home.username = "${info.username}";
  home.homeDirectory = "/home/${info.username}";

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
