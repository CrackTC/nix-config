{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.obs-studio;
in
{
  options.obs-studio = {
    enable = lib.mkEnableOption "obs-studio";
  };

  config.hmConfig.programs.obs-studio = lib.mkIf (config.gui.available && cfg.enable) {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [ ];
  };
}
