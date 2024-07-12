{ config, pkgs, lib, ... }:
let cfg = config.vivaldi; in {
  options.vivaldi = {
    enable = lib.mkEnableOption "vivaldi";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    xdg.dataFile."vivaldi/custom" = {
      source = ./custom;
      recursive = true;
    };

    home.packages = with pkgs; [
      (vivaldi.override {
        commandLineArgs = builtins.concatStringsSep " " ([ "--force-dark-mode" ] ++
          (if config.wayland.enable then [
            "--enable-features=UseOzonePlatform"
            "--ozone-platform-hint=wayland"
            "--enable-wayland-ime"
            "--enable-features=VaapiVideoDecodeLinuxGL"
            "--use-gl=angle"
            "--use-angle=gl"
          ] else [ ]));
      })
    ];
  };
}
