{ pkgs, ... }: {
  home.packages = with pkgs; with nodePackages; [
    clang-tools
    csharp-ls
    gopls
    haskell-language-server
    lua-language-server
    nil
    phpactor
    pyright
    vim-language-server
    vscode-langservers-extracted
    yaml-language-server
  ];
}
