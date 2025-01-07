{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.jq;
in
{
  options.programs.utility.jq = {
    enable = lib.mkEnableOption "jq";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.jq ];
  };
}
