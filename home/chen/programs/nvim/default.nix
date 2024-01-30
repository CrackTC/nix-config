{ ... }: {
  xdg.configFile = {
    "nvim/init.lua".source = ./config/init.lua;
    "nvim/lua" = {
      source = ./config/lua;
      recursive = true;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };
}
