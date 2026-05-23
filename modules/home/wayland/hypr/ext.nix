{
  config,
  lib,
  hostConfig,
  ...
}:
let
  cfg = config.hypr;
  mkMonitor =
    monitor:
    with monitor;
    # lua
    ''
      hl.monitor({
        output = "${name}",
        mode = "${toString weight}x${toString height}@${toString refresh}",
        position = "${toString left}x${toString top}",
        scale = "${toString scale}",
      })
    '';
  mkWorkspace =
    workspace:
    with workspace;
    # lua
    ''
      hl.workspace_rule({
        workspace = "${id}",
        default = ${if default then "true" else "false"},
        default_name = "${name}",
        monitor = "${monitor}",
      })
    '';
  inherit (hostConfig) monitors;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      extraConfig =
        let
          defaultMonitor = (builtins.elemAt monitors 1).name;
          secondaryMonitor = (builtins.head monitors).name;
          workspaces =
            [
              {
                default = false;
                name = "background";
                monitor = secondaryMonitor;
              }
              {
                default = true;
                name = "terminal";
                monitor = defaultMonitor;
              }
            ]
            ++ (
              [
                "web"
                "notes"
                "burp"
                "mail"
                "book"
                "movie"
                "chat"
                "music"
              ]
              |> map (name: {
                inherit name;
                default = false;
                monitor = defaultMonitor;
              })
            )
            |> lib.imap (
              i: workspace: {
                id = toString i;
                name = "${toString (i - 1)}-${workspace.name}";
                inherit (workspace) default monitor;
              }
            );
        in
        # lua
        ''
          ${monitors |> map mkMonitor |> lib.concatStringsSep "\n"}
          hl.monitor({
            output = "",
            mode = "preferred",
            position = "auto",
            scale = "auto",
          })

          ${workspaces |> map mkWorkspace |> lib.concatStringsSep "\n"}
        '';
    };
  };
}
