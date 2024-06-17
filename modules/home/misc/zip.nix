{ config, pkgs, lib, ... }:
let cfg = config.zip; in {
  options.zip = {
    enable = lib.mkEnableOption "(de)compress tools";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      p7zip
      unrar-wrapper
      unzipNLS
    ];
  };
}
