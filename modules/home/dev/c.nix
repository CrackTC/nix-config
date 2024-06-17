{ config, pkgs, lib, ... }:
let cfg = config.c; in {
  options.c = {
    enable = lib.mkEnableOption "c devkits";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cmake
      clang
      gdb
      gnumake
      bear
      valgrind # for memory profiling
    ];
  };
}
