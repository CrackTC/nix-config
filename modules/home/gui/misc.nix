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
      wemeet
      wechat
      krita
      inkscape
      kdePackages.ark

      wineWow64Packages.unstableFull
      winetricks
    ];

    services = lib.mkIf (!config.noctalia.enable) {
      blueman-applet.enable = true;
      network-manager-applet.enable = true;
    };
  };
}
