{ pkgs, ... }: {
  home.packages = with pkgs; [ lua-language-server ];

  xdg.configFile."coc/extensions/coc-lua-data/lua-language-server/bin/lua-language-server" = {
    text = ''
      #!/usr/bin/env bash
      exec ${pkgs.lua-language-server}/bin/lua-language-server "$@"
    '';
    executable = true;
  };
}
