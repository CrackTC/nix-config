{
  config,
  osConfig,
  pkgs,
  name,
  lib,
  ...
}:
let
  cfg = config.go;
in
{
  options.go = {
    enable = lib.mkEnableOption "go";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.go = {
      enable = true;
      package = pkgs.go_1_24;
      env = {
        GOPATH = "${osConfig.home-manager.users.${name}.home.homeDirectory}/proj/go";
      };
    };
  };
}
