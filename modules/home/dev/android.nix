{ config, pkgs, lib, ... }:
let cfg = config.android; in {
  options.android = {
    enable = lib.mkEnableOption "android devkits";
  };

  config = lib.mkIf cfg.enable {
    jetbrains.enable = true;
    hmConfig.home.packages = with pkgs; [
      android-studio-full
    ];
  };
}
