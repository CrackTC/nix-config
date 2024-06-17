{ config, pkgs, lib, ... }:
let cfg = config.haskell; in {
  options.haskell = {
    enable = lib.mkEnableOption "haskell";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ ghc ];
  };
}
