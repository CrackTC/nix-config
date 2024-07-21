{ config, lib, extraRepos, ... }:
let cfg = config.programs.utility.baidunetdisk; in {
  options.programs.utility.baidunetdisk = {
    enable = lib.mkEnableOption "baidunetdisk";
  };

  config = lib.mkIf cfg.enable {
    hmConfig.home.packages = [ extraRepos.nur.repos.xddxdd.baidunetdisk ];
  };
}
