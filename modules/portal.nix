{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      libsForQt5.xdg-desktop-portal-kde
    ];
  };
}
