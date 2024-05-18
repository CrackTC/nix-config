{ pkgs, extraRepos, ... }: {
  home.packages = with pkgs; with nodePackages; with extraRepos; [
    clang-tools
    cmake-language-server
    csharp-ls
    gopls
    haskell-language-server
    jdt-language-server
    lua-language-server
    nil
    phpactor
    myRepo.pyink
    pyright
    statix
    vim-language-server
    vscode-langservers-extracted
    yaml-language-server
  ];
}
