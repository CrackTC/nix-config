{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  imports = [
    ./backlight.nix
    ./battery.nix
    ./clock.nix
    ./cpu.nix
    ./memory.nix
    ./mpris.nix
    ./network.nix
    ./pulseaudio.nix
    ./temperature.nix
    ./tray.nix
    ./workspaces.nix
  ];

  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar = {
      modules-left = [
        "hyprland/workspaces"
        "network"
        "cpu"
        "temperature"
        "memory"
        "battery"
      ];

      modules-center = [ "mpris" ];

      modules-right = [
        "backlight"
        "pulseaudio"
        "clock"
        "tray"
      ];
    };
  };
}
