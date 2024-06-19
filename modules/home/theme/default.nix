{ config, pkgs, lib, ... }:
let cfg = config.theme; in {
  options.theme = {
    enable = lib.mkEnableOption "theme settings";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Nord)";
      size = 24;
      x11.enable = true;
      x11.defaultCursor = "Capitaine Cursors (Nord)";
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.nordic;
        name = "Nordic";
      };
      iconTheme = {
        package = pkgs.papirus-nord;
        name = "Papirus-Dark";
      };
      font = {
        name = "sans-serif";
        size = 11;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "gtk2";
    };

    dconf = {
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };

    programs.dircolors = {
      enable = true;
      settings = {
        OTHER_WRITABLE = "01;36";
      };
    };

    home.packages = with pkgs; [
      libsForQt5.qtstyleplugins
      qt6Packages.qt6gtk2
      dconf
    ];
  };
}
