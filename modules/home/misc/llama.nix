{ config, pkgs, lib, hostConfig, ... }:
let cfg = config.llama; in {
  options.llama = {
    enable = lib.mkEnableOption "llama-cpp";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.llama-cpp.override { cudaSupport = hostConfig.nvidia.enable; })
    ];
  };
}
