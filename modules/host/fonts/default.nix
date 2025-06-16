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
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      maple-mono.variable
      maple-mono.NF-CN
      twitter-color-emoji
      nerd-fonts.symbols-only
      (pkgs.callPackage ./misans.nix { })
    ];

    fontconfig = {
      hinting.style = "medium";
      defaultFonts = {
        emoji = [ "Twitter Color Emoji" ];
        monospace = [
          "Maple Mono NF CN"
          "Noto Sans Mono CJK SC"
        ];
        sansSerif = [
          # "MiSans Medium"
          "Noto Sans"
          "Noto Sans CJK SC"
        ];
        serif = [
          "Noto Serif"
          "Noto Serif CJK SC"
        ];
      };
    };
  };
}
