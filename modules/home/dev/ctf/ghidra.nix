{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.ghidra;
in
{
  options.ghidra = {
    enable = lib.mkEnableOption "ghidra";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ghidra ];
  };
}
