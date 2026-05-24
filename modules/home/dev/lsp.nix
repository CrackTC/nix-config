{
  config,
  pkgs,
  lib,
  inputs,
  system,
  ...
}:
let
  cfg = config.lsp;
in
{
  options.lsp = {
    enable = lib.mkEnableOption "lsp";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = lib.mkMerge [
      [ pkgs.yaml-language-server ]
      (lib.mkIf config.nix.enable [
        inputs.nil.packages.${system}.nil
        pkgs.statix
      ])
      (lib.mkIf config.c.enable [
        pkgs.clang-tools
        pkgs.cmake-language-server
      ])
      (lib.mkIf config.dotnet.enable [
        pkgs.csharp-ls
        pkgs.omnisharp-roslyn
      ])
      (lib.mkIf config.go.enable [ pkgs.gopls ])
      (lib.mkIf config.haskell.enable [ pkgs.haskell-language-server ])
      (lib.mkIf config.java.enable [ pkgs.jdt-language-server ])
      (lib.mkIf config.lua.enable [ pkgs.lua-language-server ])
      (lib.mkIf config.php.enable [ pkgs.phpactor ])
      (lib.mkIf config.python.enable [
        pkgs.pyright
      ])
      (lib.mkIf config.editors.nvim.enable [ pkgs.vim-language-server ])
      (lib.mkIf config.js.enable [ pkgs.vscode-langservers-extracted ])
    ];
  };
}
