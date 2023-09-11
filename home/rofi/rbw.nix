{ pkgs, ... }: {
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "http://192.168.1.100:5252";
      email = "chenrke369@gmail.com";
      lock_timeout = 3600;
    };
  };

  home.packages = with pkgs; [
    rofi-rbw
    ydotool
  ];
}
