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
    libsForQt5.ark
    libsForQt5.okular
    logisim-evolution
    obsidian
    libreoffice-qt
    (qq.override { commandLineArgs = "--ozone-platform-hint=auto --enable-wayland-ime --gtk-version=4"; })
    showmethekey
    telegram-desktop
    thunderbird
    yesplaymusic
    spotify

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
