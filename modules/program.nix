{
  programs = {
    fish.enable = true;
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "gtk2";
      };
    };
  };
}
