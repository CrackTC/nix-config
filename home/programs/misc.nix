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
    fastfetch

    wl-clip-persist

    wineWowPackages.waylandFull
    winetricks

    wpsoffice
  ];
}
