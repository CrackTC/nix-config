{ config, pkgs, lib, ... }:
let cfg = config.board; in {
  options.board = {
    enable = lib.mkEnableOption "board devkits";
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      home.packages = with pkgs; [ minicom ];
    };

    osConfig = {
      environment.etc = {
        "minirc.dfl" = {
          text = ''
            pu port             /dev/ttyUSB0
            pu baudrate         1500000
            pu bits             8
            pu parity           N
            pu stopbits         1
          '';
        };
      };
    };
  };
}
