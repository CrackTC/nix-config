{
  config,
  system,
  lib,
  inputs,
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
    home.packages = [ inputs.myRepo.packages.${system}.beatoraja ];
  };
}
