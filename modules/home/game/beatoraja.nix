{
  config,
  lib,
  extraRepos,
  ...
}:
let
  cfg = config.game.beatoraja;
in
{
  options.game.beatoraja = {
    enable = lib.mkEnableOption "beatoraja";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with extraRepos; [ myRepo.beatoraja ];
  };
}
