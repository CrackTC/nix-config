{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.ripdrag;
in
{
  options.programs.utility.ripdrag = {
    enable = lib.mkEnableOption "ripdrag";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ripdrag ];
  };
}
