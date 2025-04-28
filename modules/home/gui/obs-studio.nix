{
  pkgs,
  config,
  lib,
  hostConfig,
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
    package = pkgs.obs-studio.override {
      cudaSupport = hostConfig.nvidia.enable;
    };
  };
}
