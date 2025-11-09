{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.verilog;
in
{
  options.verilog = {
    enable = lib.mkEnableOption "verilog devkits";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      iverilog
      gtkwave
    ];
  };
}
