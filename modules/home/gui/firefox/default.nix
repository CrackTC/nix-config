{ config, lib, pkgs, ... }:
let
  cfg = config.firefox;
  inherit (cfg) profileName;
in
{
  imports = [ ./settings ];

  options.firefox = {
    enable = lib.mkEnableOption "firefox";
    profileName = lib.mkOption {
      type = lib.types.str;
      default = "default";
      description = "The name of the Firefox profile to use";
    };
  };

  config.hmConfig = lib.mkIf (config.gui.available && cfg.enable) {
    home.file.".mozilla/firefox/${profileName}/chrome" = {
      source = ./chrome;
      recursive = true;
    };

    programs.firefox = {
      enable = true;
      profiles.${profileName}.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        # gloc
        # kristofferhagen-nord-theme
        tabliss
        tampermonkey
        vimium
      ];
    };
  };
}
