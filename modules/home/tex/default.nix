{ config, pkgs, lib, ... }:
let cfg = config.tex; in {
  options.tex = {
    enable = lib.mkEnableOption "tex";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; lib.mkMerge [
      [ texlive.combined.scheme-full ]
      (lib.mkIf config.haskell.enable [ lhs2tex ])
    ];
  };
}
