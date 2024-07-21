{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.proxychains; in {
  options.programs.utility.proxychains = {
    enable = lib.mkEnableOption "proxychains";
  };

  config = lib.mkIf cfg.enable {
    osConfig.programs.proxychains = {
      enable = true;
      package = pkgs.proxychains-ng;
      proxies = {
        clash = lib.mkIf config.programs.utility.clash.enable {
          type = "socks5";
          host = "127.0.0.1";
          port = 7890;
          enable = true;
        };
      };
    };
  };
}
