{ config, pkgs, lib, ... }:
let cfg = config.shells.pwsh; in {
  options.shells.pwsh = {
    enable = lib.mkEnableOption "pwsh";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.powershell ];
  };
}
