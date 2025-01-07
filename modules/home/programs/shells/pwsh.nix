{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.shells.pwsh;
in
{
  options.programs.shells.pwsh = {
    enable = lib.mkEnableOption "pwsh";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.powershell ];
  };
}
