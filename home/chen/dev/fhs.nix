{ pkgs, ... }: {
  home.packages = with pkgs; [
    (pkgs.buildFHSUserEnv {
      name = "fhs";
      runScript = "fish";
      targetPkgs = pkgs: with pkgs; [
        # for machine learning
        cudatoolkit
        cudaPackages.cudnn
        openssl_1_1
        libGL

        # for dotnet static linking
        glib
        glibc.static
        zlib.static
        libffi
        libtool
        musl
        ghc
        gcc
        ocaml
      ];
    })
  ];
}
