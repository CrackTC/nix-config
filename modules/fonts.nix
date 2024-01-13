{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      vistafonts
      vistafonts-chs
      corefonts
      source-han-sans
      source-han-serif
      sarasa-gothic
      maple-mono
      maple-mono-SC-NF
      ubuntu_font_family
      twitter-color-emoji
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        emoji = [ "Twitter Color Emoji" ];
        monospace = [
          "Maple Mono"
          "Noto Sans Mono CJK SC"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "Source Han Sans SC"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif CJK SC"
          "Source Han Serif SC"
          "DejaVu Serif"
        ];
      };
    };
  };
}
