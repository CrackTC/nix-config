{ pkgs, extraRepos, ... }: {
  home.packages = with pkgs; [
    burpsuite
    calibre
    clash-meta
    discord
    extraRepos.myRepo.freedownloadmanager
    extraRepos.nur.repos.linyinfeng.wemeet
    gnome.nautilus
    krita
    # kuro
    libsForQt5.ark
    libsForQt5.okular
    logisim-evolution
    obsidian
    onlyoffice-bin
    qq
    showmethekey
    telegram-desktop
    thunderbird
    yesplaymusic

    asciinema
    bc
    fastfetch
    helix
    jq
    ((llama-cpp.override { cudaSupport = true; }).overrideAttrs (attrs: {
      preConfigure = ''
        cmakeFlagsArray=(
          $cmakeFlagsArray
          "-DCMAKE_CXX_FLAGS=-march=alderlake -mtune=alderlake"
        )
      '';
    }))
    p7zip
    unrar-wrapper
    unzipNLS
    wineWowPackages.waylandFull
    winetricks
  ];

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
}
