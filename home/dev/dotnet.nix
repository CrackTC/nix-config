{ pkgs, ... }: {
  home.packages = with pkgs; [
    (with dotnetCorePackages; combinePackages [
      sdk_7_0
      sdk_6_0
    ])
    csharp-ls
  ];
}
