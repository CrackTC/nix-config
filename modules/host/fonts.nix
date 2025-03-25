{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.sorac.host.font;
in
{
  options.sorac.host.font = {
    enable = lib.mkEnableOption "preferred fonts";
  };
  config.fonts = lib.mkIf cfg.enable {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      vistafonts
      vistafonts-chs
      corefonts
      source-han-sans
      source-han-serif
      sarasa-gothic
      maple-mono.variable
      maple-mono.NF-CN
      ubuntu_font_family
      twitter-color-emoji
      nerd-fonts.symbols-only
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
