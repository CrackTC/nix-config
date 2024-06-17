{config, pkgs, lib, ...}:
let cfg = config.bottles; in {
  options.bottles = {
    enable = lib.mkEnableOption "bottles";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ bottles ];
  };
}
