{ info, ... }:
let
  useNvidia = false;
  extMonitor = true;
in
{
  imports = [
    ./programs
    (import ./hypr { inherit useNvidia; inherit extMonitor; })
    ./dev
    ./game
    ./mime
    ./rofi
    ./shell
    ./theme
    ./waybar
  ];

  home.username = "${info.username}";
  home.homeDirectory = "/home/${info.username}";

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
