{ lib, ... }:
{
  options.sorac.host.virt = {
    pciPassIds = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "PCI device IDs to pass through";
    };
    kvmfrSizeMb = lib.mkOption {
      type = lib.types.int;
      default = 32;
      description = "KVMFR buffer size in MB, height * weight * 8 / 1048576 to nearest higher power of 2";
    };
  };
}
