let
  useNvidia = false;
  extMonitor = true;
in
{
  imports = [
    ./programs
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
