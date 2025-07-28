{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.aegisub;
in
{
  options.programs.utility.aegisub = {
    enable = lib.mkEnableOption "aegisub";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.aegisub
    ];
  };
}
