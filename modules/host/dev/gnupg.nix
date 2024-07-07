{ config, pkgs, lib, ... }:
let cfg = config.sorac.host.gnupg; in {
  options.sorac.host.gnupg = {
    enable = lib.mkEnableOption "gnupg";
  };

  config.programs.gnupg.agent = lib.mkIf cfg.enable {
    enable = true;
    pinentryPackage = lib.mkMerge [ pkgs.pinentry-tty ];
  };
}
