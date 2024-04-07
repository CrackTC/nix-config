{ pkgs, ... }: {
  environment.etc = {
    "minirc.dfl" = {
      text = ''
        pu port             /dev/ttyUSB0
        pu baudrate         115200
        pu bits             8
        pu parity           N
        pu stopbits         1
      '';
    };
  };
}
