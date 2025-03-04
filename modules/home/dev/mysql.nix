{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mysql;
in
{
  options.mysql = {
    enable = lib.mkEnableOption "mysql";
  };

  config = lib.mkIf cfg.enable {
    osConfig = {
      services.mysql = {
        enable = true;
        package = pkgs.mariadb;
        settings = {
          mysqld = {
            bind-address = "0.0.0.0";
          };
        };
      };
    };
  };
}
