{ config, lib, ... }:
let cfg = config.sorac.host.coredump; in {
  options.sorac.host.coredump = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Disable coredump generation";
    };
  };

  config = lib.mkIf (!cfg.enable) {
    systemd.coredump.enable = false;
    boot.kernel.sysctl."kernel.core_pattern" = lib.mkForce "|/run/current-system/sw/bin/false";
  };
}
