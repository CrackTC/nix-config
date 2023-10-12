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

    wl-clip-persist

    wineWowPackages.waylandFull
    winetricks

    wpsoffice

    extraRepos.myRepo.freedownloadmanager

    (extraRepos.nur.repos.xddxdd.wechat-uos-bin.overrideAttrs
      (oldAttrs: {
        src = pkgs.fetchurl {
          url = "https://home-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.weixin/com.tencent.weixin_2.1.5_amd64.deb";
          sha256 = "sha256-dDoWP6RZAYKOUF6/BEpNBD587HCDjkiu4AhU5XCx2WE=";
        };
      })
    )
  ];
}
