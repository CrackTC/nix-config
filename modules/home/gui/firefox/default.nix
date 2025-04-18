{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.firefox;
  inherit (cfg) profileName;
  material-fox = pkgs.fetchzip {
    url = "https://github.com/edelvarden/material-fox-updated/releases/download/v2.0.0/chrome.zip";
    hash = "sha256-wadjyouLfPblVoYSK/E8tK+0HE4f447jGrBHZoESYCk=";
  };
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
    home.file.".mozilla/firefox/${profileName}/chrome".source = material-fox;

    programs.firefox = {
      enable = true;
      profiles.${profileName}.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
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
