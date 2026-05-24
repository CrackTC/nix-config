{ config, lib, ... }:
let
  cfg = config.sorac.host.bluetooth;
in
{
  options.sorac.host.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    # WORKAROUND: https://github.com/nixos/nixpkgs/issues/514705
    services.blueman = {
      enable = true;
    };
  };
}
