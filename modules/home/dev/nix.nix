{ config, pkgs, lib, ... }:
let cfg = config.nix; in {
  options.nix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable nix devkits";
    };
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ nixfmt-rfc-style ];
  };
}
