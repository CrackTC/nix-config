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
          STEAM_FORCE_DESKTOPUI_SCALING = 1.25;
        };
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
