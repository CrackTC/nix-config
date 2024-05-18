{ extraRepos, ... }:
{
  imports = [
    ./modules
    ./style.nix
  ];

  programs.waybar = {
    enable = true;
    package = extraRepos.pkgs-master.waybar;
    settings = {
      mainBar = {
        spacing = 2;
        layer = "top";
        margin-top = 0;
        margin-left = 10;
        margin-right = 10;
      };
    };
  };
}
