{pkgs, ...}: {
  programs = {
    fish.enable = true;
    gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-qt;
      };
    };
    nix-ld.enable = true;
  };
}
