{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.media.bluray;
in
{
  options.programs.media.bluray = {
    enable = lib.mkEnableOption "bluray";
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      home.packages = [
        (pkgs.libbluray.override {
          withJava = true;
          withAACS = true;
        })
        pkgs.makemkv
      ];
    };
  };
}
