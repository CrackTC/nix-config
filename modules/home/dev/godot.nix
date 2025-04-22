{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.godot;
in
{
  options.godot = {
    enable = lib.mkEnableOption "godot";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ godot_4_3 ];
  };
}
