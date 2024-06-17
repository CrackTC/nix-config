{ config, lib, extraRepos, ... }:
let cfg = config.waybar; in {
  imports = [
    ./modules
    ./style.nix
  ];

  options.waybar = {
    enable = lib.mkEnableOption "waybar";
  };

  config = lib.mkIf cfg.enable {
    wayland.enable = true;
    hmConfig = {
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
    };
  };
}
