{ pkgs, ... }: {
  home.packages = with pkgs; [
    cudatoolkit
    cudaPackages.cudnn
  ];
}
