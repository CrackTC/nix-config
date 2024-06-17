{ config, lib, extraRepos, ... }:
let cfg = config.beatoraja; in {
  options.beatoraja = {
    enable = lib.mkEnableOption "beatoraja";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with extraRepos; [ myRepo.beatoraja ];
  };
}
