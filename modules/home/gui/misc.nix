{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.gui.misc;
in
{
  options.gui.misc = {
    enable = lib.mkEnableOption "misc gui softwares";
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.packages = with pkgs; [
      burpsuite
      # calibre
      pkgs.wemeet
      krita
      inkscape
      libsForQt5.ark

      (if config.wayland.enable then wineWowPackages.waylandFull else wineWowPackages.unstableFull)
      winetricks
    ];
    services.blueman-applet.enable = true;
    services.network-manager-applet.enable = true;
  };
}
