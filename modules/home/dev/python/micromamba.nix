{
  config,
  extraRepos,
  lib,
  ...
}:
let
  cfg = config.micromamba;
in
{
  options.micromamba = {
    enable = lib.mkEnableOption "micromamba";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with extraRepos.pkgs-stable; [ micromamba ];
  };
}
