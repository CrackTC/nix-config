{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.idea;
  idea = pkgs.writeShellScriptBin "idea" ''
    exec ${pkgs.jetbrains.idea}/bin/idea -Dawt.toolkit.name=WLToolkit "$@"
  '';
in
{
  options.idea = {
    enable = lib.mkEnableOption "idea";
  };

  config = lib.mkIf cfg.enable {
    jetbrains.enable = true;
    hmConfig = {
      home.packages = [ idea ];
    };
  };
}
