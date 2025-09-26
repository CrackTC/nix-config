{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.terminals.ghostty;
in
{
  options.terminals.ghostty = {
    enable = lib.mkEnableOption "ghostty";
    package = lib.mkPackageOption pkgs "ghostty" { };
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      programs.ghostty = {
        enable = true;
        enableBashIntegration = config.programs.shells.bash.enable;
        enableFishIntegration = config.programs.shells.fish.enable;
        enableZshIntegration = config.programs.shells.zsh.enable;
        settings = {
          font-family = "Maple Mono";
          font-synthetic-style = false;
          font-feature = [
            "ss01"
            "ss02"
            "ss03"
            "ss04"
            "ss05"
            "cv01"
            "cv02"
          ];
          font-size = 12;
          font-codepoint-map = [
            "U+2714,U+2717 = Noto Sans Symbols 2"
            "U+4E00-U+9FA5 = Maple Mono NF CN"
          ];
          freetype-load-flags = "no-hinting";
          theme = "Nord";
          mouse-hide-while-typing = true;
          window-padding-x = 3;
          window-padding-balance = true;
          window-padding-color = "extend";
          window-decoration = true;
        };
      };
    };
  };
}
