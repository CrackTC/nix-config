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
    tealdeer
    fzf

    wl-clip-persist

    wineWowPackages.waylandFull
    winetricks

    wpsoffice

    extraRepos.myRepo.freedownloadmanager
  ];

  programs.obs-studio.enable = true;
}
