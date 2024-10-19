{ config, lib, ... }:
let
  cfg = config.firefox;
  inherit (cfg) profileName;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.firefox.profiles.${profileName}.settings = {
      # https://github.com/edelvarden/material-fox-updated
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "svg.context-properties.content.enabled" = true;
      "layout.css.color-mix.enabled" = true;
      "layout.css.devPixelsPerPx" = -1;
      "userChrome.ui-chrome-refresh" = true;
      "userChrome.theme-default" = true;
    };
  };
}
