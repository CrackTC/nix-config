{ pkgs, ... }: {
  services.copyq.enable = true;
  programs = {
    pandoc.enable = true;
    bat = {
      enable = true;
      config = {
        theme = "Nord";
      };
    };
  };
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

    helix
    neofetch
    file
  ];
}
