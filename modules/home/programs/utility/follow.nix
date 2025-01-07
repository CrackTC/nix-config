{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.follow;
in
{
  options.programs.utility.follow = {
    enable = lib.mkEnableOption "follow";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.follow ];
  };
}
