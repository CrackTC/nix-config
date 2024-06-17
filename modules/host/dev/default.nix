{ config, lib, ... }:
let cfg = config.sorac.host.dev;
in
{
  imports = [ ./gnupg.nix ];
  options.sorac.host.dev = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Host is used for development";
    };
  };
  config.sorac.host = lib.mkIf cfg.enable {
    gnupg.enable = true;
  };
}
