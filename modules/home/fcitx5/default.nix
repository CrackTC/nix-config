{ config, pkgs, lib, ... }:
let cfg = config.fcitx5; in {
  options.fcitx5 = {
    enable = lib.mkEnableOption "fcitx5";
  };

  config.hmConfig = {
    i18n.inputMethod = lib.mkIf cfg.enable {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-anthy
        fcitx5-nord
      ];
    };
  };
}
