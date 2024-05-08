{ pkgs, ... }: {
  xdg.dataFile."vivaldi/custom" = {
    source = ./custom;
    recursive = true;
  };

  home.packages = with pkgs; [
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      commandLineArgs = "--force-dark-mode --enable-features=UseOzonePlatform --ozone-platform-hint=wayland --enable-wayland-ime --enable-features=VaapiVideoDecodeLinuxGL --use-gl=angle --use-angle=gl";
    })
  ];
}
