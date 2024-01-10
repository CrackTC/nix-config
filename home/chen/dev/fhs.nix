{ pkgs, ... }: {
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
      ];
    })
  ];
}
