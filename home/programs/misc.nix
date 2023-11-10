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

    logisim-evolution
    krita
    calibre
    thunderbird

    helix
    fastfetch
    bc

    wl-clip-persist

    wineWowPackages.waylandFull
    winetricks

    onlyoffice-bin
    libsForQt5.okular
    kuro

    unzipNLS
    p7zip
    unrar-wrapper

    extraRepos.myRepo.freedownloadmanager
    extraRepos.nur.repos.linyinfeng.wemeet
  ];
}
