{ config, lib, ... }:
let cfg = config.programs.utility.bat; in {
  options.programs.utility.bat = {
    enable = lib.mkEnableOption "bat";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config.theme = "Nord";
    };
  };
}
