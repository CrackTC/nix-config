{ config, lib, ... }:
let
  cfg = config.wayland;
in
{
  imports = [
    ./hypr
    ./portal.nix
    ./waybar
    ./wl-clipboard.nix
  ];

  options.wayland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "User uses wayland";
    };
  };

  config = lib.mkIf cfg.enable {
    portal.enable = true;
    gui.enable = true;
  };
}
