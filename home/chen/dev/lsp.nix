{ pkgs, ... }: {
  home.packages = with pkgs; with nodePackages; with python311Packages; [
    autopep8
    clang-tools
    csharp-ls
    gopls
    haskell-language-server
    lua-language-server
    nil
    phpactor
    pyright
    statix
    vim-language-server
    vscode-langservers-extracted
    yaml-language-server
  ];
}
