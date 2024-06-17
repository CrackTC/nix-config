{ config, lib, ... }:
let cfg = config.sorac.host.joycond; in {
  options.sorac.host.joycond = {
    enable = lib.mkEnableOption "joycond";
  };

  config = lib.mkIf cfg.enable {
    services.joycond.enable = true;
    boot.initrd.kernelModules = [ "hid_nintendo" ];
  };
}
