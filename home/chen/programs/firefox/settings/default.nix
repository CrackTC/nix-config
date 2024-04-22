profileName: { pkgs, info, ... }: {
  imports = map (module: module profileName) (map import [
    ./scroll.nix
    ./theme.nix
  ]);
  programs.firefox = {
    package = pkgs.firefox.override {
      extraPrefs = ''
        pref("general.config.sandbox_enabled", false);

        try {
          const Services = globalThis.Services;
          function ConfigJS() { Services.obs.addObserver(this, 'chrome-document-global-created', false); }
          ConfigJS.prototype = {
            observe: function (aSubject) { aSubject.addEventListener('DOMContentLoaded', this, {once: true}); },
            handleEvent: function (aEvent) {
              let document = aEvent.originalTarget; let window = document.defaultView; let location = window.location;
              if (/^(chrome:(?!\/\/(global\/content\/commonDialog|browser\/content\/webext-panels)\.x?html)|about:(?!blank))/i.test(location.href)) {
                if (window._gBrowser) {
                  // const newNavigatorTab = window.document.getElementById('key_newNavigatorTab')
                  // newNavigatorTab.setAttribute('modifiers', ''')
                  // newNavigatorTab.setAttribute('key', 't')
                }
              }
            }
          };
          if (!Services.appinfo.inSafeMode) { new ConfigJS(); }
        } catch(ex) {};
      '';
    };
    profiles.${profileName}.settings = {
      "trailhead.firstrun.didSeeAboutWelcome" = true;
      "intl.locale.requested" = "zh-CN,en-US";
      "layout.css.devPixelsPerPx" = -1;
      "signon.rememberSignons" = false;
      "browser.tabs.tabmanager.enabled" = false;
    };
    policies = {
      DefaultDownloadDirectory = "/home/${info.username}/Downloads";
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "newtab";
      Proxy = {
        Mode = "manual";
        Locked = false;
        SOCKSProxy = "localhost:7890";
        SOCKSVersion = 5;
        Passthrough = "<local>";
        UseProxyForDNS = true;
      };
    };
  };
}
