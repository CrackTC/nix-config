{ config, lib, ... }:
let cfg = config.terminals.kitty; in {
  options.terminals.kitty = {
    enable = lib.mkEnableOption "kitty";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      extraConfig = lib.strings.concatStringsSep "\n" [
        "symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6AA,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF,U+F0001-U+F1AF0 Symbols Nerd Font"
        "symbol_map U+2714,U+2717 Noto Sans Symbols 2"
        "symbol_map U+4E00-U+9FA5 Maple Mono SC NF"
        "font_features MapleMono-Regular +ss01 +ss02 +ss03 +ss04 +ss05 +cv02"
        "font_features MapleMono-Bold +ss01 +ss02 +ss03 +ss04 +ss05 +cv02"
        "font_features MapleMono-Italic +ss01 +ss02 +ss03 +ss04 +ss05 +cv02"
        "font_features MapleMono-BoldItalic +ss01 +ss02 +ss03 +ss04 +ss05 +cv02"
      ];
      settings = {
        font_family = "Maple Mono";
        bold_font = "Maple Mono Bold";
        italic_font = "Maple Mono Italic";
        bold_italic_font = "Maple Mono BoldItalic";
        font_size = 14;
        cursor_text_color = "background";
        cursor_blink_interval = 0;
        window_padding_width = "5 10";
        close_on_child_death = true;
      };
      shellIntegration = {
        enableBashIntegration = config.programs.shells.bash.enable;
        enableFishIntegration = config.programs.shells.fish.enable;
        enableZshIntegration = config.programs.shells.zsh.enable;
      };
      theme = "Nord";
    };
  };
}
