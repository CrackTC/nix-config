{ pkgs, info, ... }: {
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "http://cracktc.tpddns.cn:5252";
      inherit (info) email;
      lock_timeout = 9999999999;
      pinentry = "qt";
    };
  };

  home.packages = with pkgs; [
    ydotool
  ];
}
