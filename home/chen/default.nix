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
    ./waybar
    ./xdg
  ];

  home = {
    username = "${info.username}";
    homeDirectory = "/home/${info.username}";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
