{ lib, ... }:
{
  systemd.coredump.enable = false;
  boot.kernel.sysctl."kernel.core_pattern" = lib.mkForce "|/run/current-system/sw/bin/false";
}
