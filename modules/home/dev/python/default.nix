{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.python;
in
{
  imports = [ ./micromamba.nix ];
  options.python = {
    enable = lib.mkEnableOption "python devkits";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ python3 ];
  };

  config.micromamba.enable = lib.mkIf cfg.enable true;
}
