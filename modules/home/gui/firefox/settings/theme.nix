{ config, lib, ... }:
let
  cfg = config.firefox;
  inherit (cfg) profileName;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.firefox.profiles.${profileName}.settings = {
      # MaterialFox
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "svg.context-properties.content.enabled" = true;
      "browser.tabs.tabClipWidth" = 83;
      "security.insecure_connection_text.enabled" = true;
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}
