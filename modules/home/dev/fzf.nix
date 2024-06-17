{ config, lib, ... }:
let cfg = config.fzf; in {
  options.fzf = {
    enable = lib.mkEnableOption "fzf";
  };
  config.hmConfig.programs.fzf.enable = lib.mkIf cfg.enable true;
}
