{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.asciinema; in {
  options.programs.utility.asciinema = {
    enable = lib.mkEnableOption "asciinema";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.asciinema ];
  };
}
