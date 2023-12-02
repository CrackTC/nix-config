profileName: {
  imports = map (module: module profileName) (map import [
    ./scroll.nix
    ./theme.nix
  ]);
  programs.firefox.profiles.${profileName}.settings = {
    "trailhead.firstrun.didSeeAboutWelcome" = true;
    "intl.locale.requested" = "zh-CN,en-US";
    "layout.css.devPixelsPerPx" = 1.5;
    "signon.rememberSignons" = false;
    "browser.tabs.tabmanager.enabled" = false;
  };
}
