{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.bsdiff;
in
{
  options.programs.utility.bsdiff = {
    enable = lib.mkEnableOption "bsdiff";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.bsdiff ];
  };
}
