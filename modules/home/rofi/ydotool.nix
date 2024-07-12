{ config, pkgs, lib, name, ... }:
let cfg = config.ydotool; in {
  options.ydotool = {
    enable = lib.mkEnableOption "ydotool";
  };

  config = lib.mkIf cfg.enable {
    hmConfig.home.packages = with pkgs; [ ydotool ];

    osConfig = {
      hardware.uinput.enable = true;
      users.users.${name}.extraGroups = [ "uinput" ];
    };
  };
}
