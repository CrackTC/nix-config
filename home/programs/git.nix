{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "CrackTC";
    userEmail = "chenrke369@gmail.com";
    signing = {
      key = "32EC77DBD23E9EB1";
      signByDefault = true;
    };
    lfs.enable = true;
  };

  home.packages = with pkgs; [ gnupg ];
}
