{ config, pkgs, lib, ... }:
let
  cfg = config.fhs;
  fontDir = pkgs.stdenv.mkDerivation {
    name = "fontDir";
    buildCommand = ''
      mkdir -p $out/share
      ln -s /run/current-system/sw/share/X11/fonts $out/share/fonts
    '';
  };
in
{
  options.fhs = {
    enable = lib.mkEnableOption "fhs";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (pkgs.buildFHSUserEnv {
        name = "fhs";
        runScript = config.programs.preferredShell;
        targetPkgs = pkgs: with pkgs;
          # dotnet static linking
          [ fontDir ]
          ++ (if config.dotnet.enable then [ glib glibc.static zlib.static icu.dev musl openssl ] else [ ])
          ++ (if config.c.enable then [ gcc ] else [ ])
          ++ (if config.haskell.enable then [ ghc ] else [ ]);
      })
    ];
  };
}
