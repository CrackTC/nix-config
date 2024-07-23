{ pkgs, config, lib, ... }:
let cfg = config.programs.utility.rbw; in {
  imports = [ ./ydotool.nix ];

  options.programs.utility.rbw = {
    enable = lib.mkEnableOption "rbw";
    base_url = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The base URL of the Bitwarden server";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.utility.ydotool.enable = true;
    hmConfig = {
      programs.rbw = {
        enable = true;
        settings = {
          inherit (cfg) base_url;
          inherit (config) email;
          lock_timeout = 9999999999;
          pinentry = pkgs.${config.pinentry};
        };
      };
    };
  };
}
