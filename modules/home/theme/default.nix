{ config, pkgs, lib, ... }:
let cfg = config.theme; in {
  options.theme = {
    enable = lib.mkEnableOption "theme settings";
  };

  config = lib.mkIf cfg.enable {
    osConfig = {
      gtk.iconCache.enable = true;
      qt = {
        enable = true;
        platformTheme = "qt5ct";
        style = "kvantum";
      };
    };
    hmConfig =
      let
        cursorThemePackage = pkgs.capitaine-cursors-themed;
        cursorTheme = "Capitaine Cursors (Nord)";
        cursorSize = 24;

        themePackage = pkgs.nordic;
        themeName = "Nordic";

        iconThemePackage = pkgs.papirus-nord.override { accent = "frostblue3"; };
        iconThemeName = "Papirus-Dark";
      in
      {
        home.pointerCursor = {
          package = cursorThemePackage;
          name = cursorTheme;
          size = cursorSize;

          gtk.enable = true;
          hyprcursor.enable = lib.mkIf config.hypr.enable true;
          x11 = { enable = true; defaultCursor = cursorTheme; };
        };

        gtk = {
          enable = true;
          theme = { package = themePackage; name = themeName; };
          iconTheme = {
            package = iconThemePackage;
            name = iconThemeName;
          };
          font = {
            name = "sans-serif";
            size = 11;
          };
        };

        xdg.configFile = {
          "Kvantum/kvantum.kvconfig".text = ''
            [General]
            theme=Nordic-Solid
          '';

          "Kvantum/Nordic-Solid".source = pkgs.fetchzip {
            url = "https://github.com/EliverLara/Nordic/raw/32e3176db314086cf79074bf06b936f8d62d7b15/kde/kvantum/Nordic-Solid.tar.xz";
            hash = "sha256-R21N5YqHsf6bwA6MvwV0GY7HAOK4me0U0x9Yceu11Yw=";
          };
        };

        dconf.settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };

        programs.dircolors = {
          enable = true;
          settings = {
            OTHER_WRITABLE = "01;36";
          };
        };

        home.packages = with pkgs; [ dconf ];
      };
  };
}
