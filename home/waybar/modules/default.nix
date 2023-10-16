{
  imports = [
    ./cava.nix
    ./workspaces.nix
    ./tray.nix
    ./clock.nix
    ./cpu.nix
    ./memory.nix
    ./temperature.nix
    ./backlight.nix
    ./battery.nix
    ./network.nix
    ./pulseaudio.nix
  ];

  programs.waybar.settings.mainBar = {
    modules-left = [ "hyprland/workspaces" "network" "cpu" "temperature" "memory" "battery" ];
    modules-center = [ "custom/cava" ];
    modules-right = [ "backlight" "pulseaudio" "clock" "tray" ];
  };
}
