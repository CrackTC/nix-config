{ config, pkgs, lib, ... }:
let
  cfg = config.programs.media.spotify;
  spotify =
    if config.wayland.enable then
      (pkgs.spotify.overrideAttrs {
        postInstall = ''
          wrapProgram $out/share/spotify/spotify \
            --add-flags "--enable-features=WaylandWindowDecorations --ozone-platform=wayland --gtk-version=4 --enable-wayland-ime"
        '';
      })
    else pkgs.spotify;
in
{
  options.programs.media.spotify = {
    enable = lib.mkEnableOption "spotify";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [ spotify ];
    };
  };
}
