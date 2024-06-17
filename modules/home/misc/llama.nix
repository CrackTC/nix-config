{ config, pkgs, lib, hostConfig, ... }:
let cfg = config.llama; in {
  options.llama = {
    enable = lib.mkEnableOption "llama-cpp";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [
      ((pkgs.llama-cpp.override { cudaSupport = hostConfig.nvidia.enable; }).overrideAttrs (attrs: {
        preConfigure = ''
          cmakeFlagsArray=(
            $cmakeFlagsArray
            "-DCMAKE_CXX_FLAGS=-march=${hostConfig.cpu} -mtune=${hostConfig.cpu}"
          )
        '';
      }))
    ];
  };
}
