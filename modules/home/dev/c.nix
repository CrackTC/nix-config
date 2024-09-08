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

      # https://discourse.nixos.org/t/statically-linked-mingw-binaries/38395/4
      (
        let
          inherit (pkgs.pkgsCross.mingwW64) buildPackages;
        in
        buildPackages.wrapCC (buildPackages.gcc-unwrapped.override {
          threadsCross = {
            model = "win32";
            package = null;
          };
        })
      )
    ];
  };
}
