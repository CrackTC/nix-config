{ config, lib, ... }:
let
  cfg = config.programs.utility.lazygit;
in
{
  options.programs.utility.lazygit = {
    enable = lib.mkEnableOption "lazygit";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.lazygit.enable = true;
    xdg.configFile."lazygit/config.yml".source = ./config.yml;
  };
}
