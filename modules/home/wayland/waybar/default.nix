{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.waybar;
in
{
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
        package = pkgs.waybar;
        settings = {
          mainBar = {
            spacing = 0;
            layer = "top";
            margin-top = 0;
            margin-left = 0;
            margin-right = 0;
          };
        };
      };
    };
  };
}
