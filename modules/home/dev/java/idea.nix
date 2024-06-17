{ config, pkgs, lib, ... }:
let cfg = config.idea; in {
  options.idea = {
    enable = lib.mkEnableOption "idea";
  };

  config = lib.mkIf cfg.enable {
    jetbrains.enable = true;
    hmConfig = {
      home.packages = [ pkgs.jetbrains.idea-ultimate ];
    };
  };
}
