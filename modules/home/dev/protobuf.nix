{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.protobuf;
in
{
  options.protobuf = {
    enable = lib.mkEnableOption "protobuf";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ protobuf ];
  };
}
