{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.zip; in {
  options.programs.utility.zip = {
    enable = lib.mkEnableOption "(de)compress tools";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      zip
      (p7zip.override { enableUnfree = true; })
      unzipNLS
    ];
  };
}
