{ config, pkgs, lib, ... }:
let cfg = config.fcitx5; in {
  options.fcitx5 = {
    enable = lib.mkEnableOption "fcitx5";
  };

  config.osConfig = {
    i18n.inputMethod = lib.mkIf cfg.enable {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = config.wayland.enable;
        plasma6Support = true;
        addons = with pkgs; [
          fcitx5-anthy
          fcitx5-nord

          (fcitx5-rime.override {
            rimeDataPkgs = [
              (callPackage ./rime-frost.nix { })
            ];
          })
        ];
      };
    };
  };
}
