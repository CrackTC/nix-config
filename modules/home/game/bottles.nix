{ config, pkgs, lib, ... }:
let cfg = config.game.bottles; in {
  options.game.bottles = {
    enable = lib.mkEnableOption "bottles";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ bottles ];
  };
}
