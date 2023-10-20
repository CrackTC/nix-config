{ pkgs, info, ... }: {
  programs.git = {
    enable = true;
    userName = info.nickname;
    userEmail = info.email;
    signing = {
      key = "32EC77DBD23E9EB1";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
    lfs.enable = true;
  };

  home.packages = with pkgs; [ gnupg ];
}
