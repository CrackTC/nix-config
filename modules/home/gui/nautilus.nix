{ config, pkgs, lib, ... }:
let cfg = config.nautilus; in {
  options.nautilus = {
    enable = lib.mkEnableOption "nautilus";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nautilus ];
    xdg.mimeApps.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
  };
}
