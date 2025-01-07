{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.tex;
in
{
  options.programs.utility.tex = {
    enable = lib.mkEnableOption "tex";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      lib.mkMerge [
        [ texlive.combined.scheme-full ]
        (lib.mkIf config.haskell.enable [ lhs2tex ])
      ];
  };
}
