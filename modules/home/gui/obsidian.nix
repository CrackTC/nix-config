{ config, pkgs, lib, ... }:
let cfg = config.obsidian; in {
  options.obsidian = {
    enable = lib.mkEnableOption "obsidian";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (obsidian.override {
        commandLineArgs =
          if config.wayland.enable
          then "--ozone-platform-hint=auto --enable-wayland-ime --gtk-version=4"
          else "";
      })
    ];
  };
}
