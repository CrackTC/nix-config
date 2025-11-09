{
  config,
  pkgs,
  lib,
  name,
  ...
}:
let
  cfg = config.android;
in
{
  options.android = {
    enable = lib.mkEnableOption "android devkits";
  };

  config = lib.mkIf cfg.enable {
    jetbrains.enable = true;
    hmConfig.home.packages = [
      (pkgs.androidStudioPackages.beta.override { forceWayland = true; })
    ];

    osConfig = {
      programs.adb.enable = true;
      users.users.${name}.extraGroups = [ "adbusers" ];
    };
  };
}
