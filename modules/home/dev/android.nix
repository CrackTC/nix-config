{ config, pkgs, lib, name, extraRepos, ... }:
let cfg = config.android; in {
  options.android = {
    enable = lib.mkEnableOption "android devkits";
  };

  config = lib.mkIf cfg.enable {
    jetbrains.enable = true;
    hmConfig.home.packages = [
      (extraRepos.pkgs-master.android-studio.override { forceWayland = true; })
    ];

    osConfig = {
      programs.adb.enable = true;
      users.users.${name}.extraGroups = [ "adbusers" ];
      services.udev.packages = [
        pkgs.android-udev-rules
      ];
    };
  };
}