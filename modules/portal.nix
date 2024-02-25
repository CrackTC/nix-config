{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    xdgOpenUsePortal = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-kde
    ];
  };
}
