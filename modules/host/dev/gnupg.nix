{ config, pkgs, lib, ... }:
let cfg = config.sorac.host.gnupg; in {
  options.sorac.host.gnupg = {
    enable = lib.mkEnableOption "gnupg";
  };

  config.programs.gnupg.agent = lib.mkIf cfg.enable {
    enable = true;
    pinentryPackage = lib.mkMerge [
      (lib.mkIf config.sorac.host.gui.enable pkgs.pinentry-qt)
      (lib.mkIf (!config.sorac.host.gui.enable) pkgs.pinentry-tty)
    ];
  };
}
