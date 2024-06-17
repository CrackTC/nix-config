{config, pkgs, lib, ...}:
let cfg = config.neovide; in {
  options.neovide = {
    enable = lib.mkEnableOption "neovide";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ pkgs.neovide ];
  };
}
