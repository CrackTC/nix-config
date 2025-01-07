{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.media.jellyfin-mpv-shim;
in
{
  options.programs.media.jellyfin-mpv-shim = {
    enable = lib.mkEnableOption "jellyfin-mpv-shim";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    systemd.user.services.jellyfin-mpv-shim = {
      Unit = {
        Description = "Jellyfin MPV Shim";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${lib.getExe pkgs.jellyfin-mpv-shim}";
      };
    };
  };
}
