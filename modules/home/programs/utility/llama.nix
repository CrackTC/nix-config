{
  config,
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  cfg = config.programs.utility.llama;
in
{
  options.programs.utility.llama = {
    enable = lib.mkEnableOption "llama-cpp";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.llama-cpp.override { cudaSupport = hostConfig.nvidia.enable; })
      pkgs.ollama-cuda
    ];
  };
}
