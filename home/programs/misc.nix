{ pkgs, ... }: {
  home.packages = with pkgs; [
    clash-verge
    discord
    telegram-desktop
    spotify
    obsidian
    qq
    burpsuite

    logisim
    krita
    calibre
    thunderbird

    helix
    neofetch

    wl-clip-persist

    wineWowPackages.waylandFull
    winetricks

    wpsoffice
  ];
}
