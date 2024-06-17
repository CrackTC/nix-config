{config, pkgs, lib, ...}:
let cfg = config.thunderbird; in {
  options.thunderbird = {
    enable = lib.mkEnableOption "thunderbird";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.thunderbird ];
  };
}
