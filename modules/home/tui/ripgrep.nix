{ config, lib, ... }:
let
  cfg = config.ripgrep;
in
{
  options.ripgrep = {
    enable = lib.mkEnableOption "ripgrep";
  };

  config.hmConfig.programs.ripgrep.enable = cfg.enable;
}
