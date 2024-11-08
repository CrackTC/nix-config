{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.anki; in {
  options.programs.utility.anki = {
    enable = lib.mkEnableOption "anki";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.anki ];
  };
}
