{ config, pkgs, lib, ... }:
let cfg = config.showmethekey; in {
  options.showmethekey = {
    enable = lib.mkEnableOption "showmethekey";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ showmethekey ];
  };
}
