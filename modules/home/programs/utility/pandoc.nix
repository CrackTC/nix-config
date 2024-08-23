{ config, lib, ... }:
let cfg = config.programs.utility.pandoc; in {
  options.programs.utility.pandoc = {
    enable = lib.mkEnableOption "pandoc";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.pandoc.enable = true;
  };
}
