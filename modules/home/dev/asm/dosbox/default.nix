{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.dosbox;
in
{
  options.dosbox = {
    enable = lib.mkEnableOption "dosbox";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ dosbox ];
    home.file.".dosbox/mapper-0.74-3.map" = lib.mkIf config.colemak.enable {
      source = ./mapper-0.74-3.map;
    };
  };
}
