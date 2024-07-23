{ config, pkgs, lib, extraRepos, ... }:
let cfg = config.portal; in {
  options.portal = {
    enable = lib.mkEnableOption "portal";
  };
  config.osConfig = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      config.common.default = "*";
      xdgOpenUsePortal = false;
      extraPortals = lib.mkMerge [
        (lib.mkIf config.hypr.enable [ extraRepos.pkgs-master.xdg-desktop-portal-hyprland ])
        [ pkgs.xdg-desktop-portal-gtk ]
      ];
    };
  };
}
