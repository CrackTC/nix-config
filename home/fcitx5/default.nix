{ pkgs, ... }: {
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = with pkgs;[
          fcitx5-gtk
          fcitx5-chinese-addons
          fcitx5-anthy
        ];
      };
    };
  };

  home.packages = with pkgs; [
    libsForQt5.fcitx5-qt
    libsForQt5.qt5.qtwayland
  ];
}
