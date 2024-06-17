{ config, lib, ... }:
let cfg = config.sorac.host.laptop; in {
  options.sorac.host.laptop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Host is laptop";
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      udisks2.enable = true;
      fwupd.enable = true;
    };

    sorac.host = {
      bluetooth.enable = true;
      powerManagement.enable = true;
    };
  };
}
