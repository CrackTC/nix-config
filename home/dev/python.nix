{ pkgs, ... }: {
  home.packages = with pkgs; [
    python3
    micromamba
    yapf
    (pkgs.buildFHSUserEnv {
      name = "fhs";
      runScript = "fish";
      targetPkgs = pkgs: with pkgs; [
        cudatoolkit
        cudaPackages.cudnn
        openssl_1_1
        libGL
      ];
    })
  ];
}
