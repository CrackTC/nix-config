{ pkgs, extraRepos, ... }: {
  home.packages = with pkgs; [
    (with dotnetCorePackages; combinePackages [
      sdk_8_0
      sdk_7_0
      sdk_6_0
    ])

    extraRepos.myRepo.csharprepl
  ];
}
