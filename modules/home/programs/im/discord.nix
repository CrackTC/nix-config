{ config, pkgs, lib, ... }:
let cfg = config.programs.im.discord; in {
  options.programs.im.discord = {
    enable = lib.mkEnableOption "discord";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [
        (pkgs.discord.overrideAttrs (oldAttrs: {
          postInstall = oldAttrs.postInstall + ''
            wrapProgram $out/opt/Discord/Discord \
              --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WaylandWindowDecorations --use-gl=desktop"
          '';
        }))
      ];
    };
  };
}
