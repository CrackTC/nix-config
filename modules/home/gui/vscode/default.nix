{ config, pkgs, lib, ... }:
let cfg = config.vscode; in {
  options.vscode = {
    enable = lib.mkEnableOption "vscode";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = (pkgs.vscode.override {
        commandLineArgs = if config.wayland.enable then "--ozone-platform-hint=wayland --enable-wayland-ime" else "";
      }).fhs;
    };
  };
}
