{ config, lib, ... }:
let cfg = config.programs.shells.bash; in {
  options.programs.shells.bash = {
    enable = lib.mkEnableOption "bash";
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      programs.bash.enable = true;
    };
  };
}
