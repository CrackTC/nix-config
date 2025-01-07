{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.game.gamescope;
in
{
  options.game.gamescope = {
    enable = lib.mkEnableOption "gamescope";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ gamescope ];
  };
}
