{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.game.steam;
in
{
  options.game.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf cfg.enable {
    osConfig.programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          GDK_SCALE = 2;
        };
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
