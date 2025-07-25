{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.localsend;
in
{
  options.programs.utility.localsend = {
    enable = lib.mkEnableOption "localsend";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.localsend ];
  };
}
