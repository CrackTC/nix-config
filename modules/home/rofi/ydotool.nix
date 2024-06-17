{ config, pkgs, lib, ... }:
let
  cfg = config.ydotool;
  username = config._module.args.name;
in
{
  options.ydotool = {
    enable = lib.mkEnableOption "ydotool";
  };

  config = lib.mkIf cfg.enable {
    hmConfig.home.packages = with pkgs; [ ydotool ];

    osConfig = {
      hardware.uinput.enable = true;
      users.users.${username}.extraGroups = [ "uinput" ];
    };
  };
}
