{ config, pkgs, lib, extraRepos, ... }:
let cfg = config.lsp; in {
  options.lsp = {
    enable = lib.mkEnableOption "lsp";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; with nodePackages; with extraRepos; lib.mkMerge [
      [ yaml-language-server ]
      (lib.mkIf config.nix.enable [ nil statix ])
      (lib.mkIf config.c.enable [ clang-tools cmake-language-server ])
      (lib.mkIf config.dotnet.enable [ csharp-ls ])
      (lib.mkIf config.go.enable [ gopls ])
      (lib.mkIf config.haskell.enable [ haskell-language-server ])
      (lib.mkIf config.java.enable [ jdt-language-server ])
      (lib.mkIf config.lua.enable [ lua-language-server ])
      (lib.mkIf config.php.enable [ phpactor ])
      (lib.mkIf config.python.enable [ myRepo.pyink pyright ])
      (lib.mkIf config.editors.nvim.enable [ vim-language-server ])
      (lib.mkIf config.js.enable [ vscode-langservers-extracted ])
    ];
  };
}
