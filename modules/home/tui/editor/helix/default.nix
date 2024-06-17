{ config, pkgs, lib, ... }:
let cfg = config.editors.helix; in {
  options.editors.helix = {
    enable = lib.mkEnableOption "helix";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.helix ];
  };
}
