{
  config,
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

  config.osConfig = lib.mkIf cfg.enable {
    programs.localsend.enable = true;
  };
}
