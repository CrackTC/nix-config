{ pkgs, extraRepos, ... }: {
  home.packages = with pkgs; [
    clash-meta
    discord
    telegram-desktop
    (spotify.overrideAttrs (attrs: {
      nativeBuildInputs = attrs.nativeBuildInputs ++ [ makeWrapper ];
      postInstall = ''
        wrapProgram $out/share/spotify/spotify \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libGL ]}
      '';
    }))
    yesplaymusic
    obsidian
    (qq.overrideAttrs (attrs: {
      buildInputs = attrs.buildInputs ++ [ pkgs.libnotify ];
      postInstall = ''
        ln -s ${pkgs.libnotify}/lib/libnotify.so \
          $out/opt/QQ/libnotify.so
      '';
    }))
    burpsuite

    gnome.nautilus
    libsForQt5.ark

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
    asciinema

    extraRepos.myRepo.freedownloadmanager
    extraRepos.nur.repos.linyinfeng.wemeet
  ];

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
}
