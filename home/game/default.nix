{ extraRepos, pkgs, ... }: {
  home.packages = with extraRepos; with pkgs; [
    myRepo.beatoraja
    yuzu-mainline
  ];
}
