{ config, lib, name, ... }:
let
  cfg = config.firefox;
  inherit (cfg) profileName;
in
{
  imports = [
    ./scroll.nix
    ./theme.nix
  ];

  config.hmConfig = lib.mkIf cfg.enable {
    programs.firefox = {
      profiles.${profileName}.settings = {
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "intl.locale.requested" = "en-US";
        "signon.rememberSignons" = false;
        "browser.tabs.tabmanager.enabled" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
      policies = {
        DefaultDownloadDirectory = "/home/${name}/Downloads";
        DisableFeedbackCommands = true;
        DisableFirefoxAccounts = true;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "newtab";
        Proxy = lib.mkIf config.programs.utility.clash.enable {
          Mode = "manual";
          Locked = false;
          SOCKSProxy = "localhost:7890";
          SOCKSVersion = 5;
          Passthrough = "<local>";
          UseProxyForDNS = true;
        };
      };
    };
  };
}
