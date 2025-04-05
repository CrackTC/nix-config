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
        ExecStartPre = pkgs.writeShellScript "wait-wg.sh" ''
          until ${pkgs.iputils}/bin/ping -c 1 192.168.96.1; do sleep 1; done
        '';
        ExecStart = "${lib.getExe pkgs.jellyfin-mpv-shim}";
      };
    };
  };
}
