{ pkgs, extraRepos, ... }: {
  home.packages = with pkgs; [
    clash-verge
    discord
    telegram-desktop
    spotify
    yesplaymusic
    obsidian
    qq
    burpsuite

    logisim
    krita
    calibre
    thunderbird

    helix
    fastfetch

    wl-clip-persist

    wineWowPackages.waylandFull
    winetricks

    wpsoffice
    libsForQt5.okular
    kuro

    extraRepos.myRepo.freedownloadmanager
  ];
}
