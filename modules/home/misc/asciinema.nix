{ config, pkgs, lib, ... }:
let cfg = config.asciinema; in {
  options.asciinema = {
    enable = lib.mkEnableOption "asciinema";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.asciinema ];
  };
}
