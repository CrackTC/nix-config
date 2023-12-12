{ pkgs, info, ... }: {
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "http://cracktc.tpddns.cn:5252";
      inherit (info) email;
      lock_timeout = 3600;
    };
  };

  home.packages = with pkgs; [
    rofi-rbw-wayland
    ydotool
  ];
}
