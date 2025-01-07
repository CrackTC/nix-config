{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.php;
in
{
  options.php = {
    enable = lib.mkEnableOption "php";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.phpactor ];
  };
}
