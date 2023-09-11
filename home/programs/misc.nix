{ pkgs, ... }: {
  services.copyq.enable = true;
  home.packages = with pkgs; [
    clash-verge
    discord
    telegram-desktop
    spotify
    obsidian
    qq

    logisim
    krita
    calibre

    helix
    neofetch
  ];
}
