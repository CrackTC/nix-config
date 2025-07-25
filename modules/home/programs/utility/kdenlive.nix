{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.kdenlive;
in
{
  options.programs.utility.kdenlive = {
    enable = lib.mkEnableOption "kdenlive";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.kdePackages.kdenlive ];
  };
}
