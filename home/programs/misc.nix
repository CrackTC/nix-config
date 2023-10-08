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
    fzf

    wl-clip-persist

    wineWowPackages.waylandFull
    winetricks

    wpsoffice

    extraRepos.myRepo.freedownloadmanager
  ];
}
