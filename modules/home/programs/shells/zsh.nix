{ config, lib, ... }:
let
  cfg = config.programs.shells.zsh;
in
{
  options.programs.shells.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      programs.zsh.enable = true;
    };

    osConfig = {
      programs.zsh.enable = true;
    };
  };
}
