{
  programs = {
    fish.enable = true;
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "qt";
      };
    };
    nix-ld.enable = true;
  };
}
