{ extraRepos, ... }: {
  home.packages = with extraRepos; [
    myRepo.beatoraja
  ];
}
