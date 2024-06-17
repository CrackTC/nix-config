{ config, pkgs, lib, ... }:
let cfg = config.sorac.host.man; in {
  options.sorac.host.man = {
    enable = lib.mkEnableOption "man";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];

    documentation.dev.enable = true;
    documentation.man.generateCaches = false;
  };
}
