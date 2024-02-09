{ pkgs, ... }:
let
  fontDir = pkgs.stdenv.mkDerivation {
    name = "fontDir";
    buildCommand = ''
      mkdir -p $out/share
      ln -s /run/current-system/sw/share/X11/fonts $out/share/fonts
    '';
  };
in {
  home.packages = with pkgs; [
    (pkgs.buildFHSUserEnv {
      name = "fhs";
      runScript = "fish";
      targetPkgs = pkgs: with pkgs; [
        # for dotnet static linking
        glib
        glibc.static
        zlib.static
        libffi
        libtool
        icu.dev
        musl
        ghc
        gcc
        ocaml
        openssl
        fontDir
      ];
    })
  ];
}
