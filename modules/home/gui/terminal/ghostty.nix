{ config, lib, extraRepos, ... }:
let cfg = config.terminals.ghostty; in {
  options.terminals.ghostty = {
    enable = lib.mkEnableOption "ghostty";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ extraRepos.ghostty.ghostty ];
    xdg.configFile."ghostty/config".text = ''
      font-family = Maple Mono
      font-synthetic-style = false
      font-feature = ss01
      font-feature = ss02
      font-feature = ss03
      font-feature = ss04
      font-feature = ss05
      font-feature = cv01
      font-feature = cv02
      font-size = 12
      font-codepoint-map = U+2714,U+2717 = Noto Sans Symbols 2
      font-codepoint-map = U+4E00-U+9FA5 = Maple Mono SC NF
      freetype-load-flags = no-hinting

      theme = dark: nord, light: nord-light

      mouse-hide-while-typing = true

      scrollback-limit = 4294967295
      window-padding-x = 1
      window-padding-balance = true
      window-padding-color = extend
      window-decoration = true
    '';
  };
}
