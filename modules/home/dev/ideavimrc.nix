{ config, lib, ... }:
let
  cfg = config.ideavimrc;
in
{
  options.ideavimrc = {
    enable = lib.mkEnableOption "ideavimrc";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.file.".ideavimrc".text = lib.mkMerge [
      (lib.mkIf config.colemak.enable ''
        noremap h h
        noremap n j
        noremap e k
        noremap i l
        noremap l u
        noremap u i
        nnoremap ss dd
        noremap s d
        noremap S D
        noremap y o
        noremap Y O
        noremap j y
        noremap O :
        noremap K N
        noremap k n
        noremap dd gg
        noremap d g
        noremap ; p
        noremap D G
      '')
      (lib.mkMerge [
        (lib.mkIf config.colemak.enable ''
          noremap R :w<CR>
          noremap o :

          nnoremap ds :action GotoDeclaration<CR>
          nnoremap dS :action GotoTypeDeclaration<CR>
          nnoremap sc K
          noremap dc :action CommentByLineComment<CR>
        '')
        (lib.mkIf (!config.colemak.enable) ''
          noremap S :w<CR>
          noremap ; :

          nnoremap gd :action GotoDeclaration<CR>
          nnoremap gD :action GotoTypeDeclaration<CR>
          nnoremap dc K
          noremap gc :action CommentByLineComment<CR>
        '')
      ])
      ''
        noremap Q :q<CR>
        nnoremap <Space>a :action QuickActions<CR>

        set number
        set relativenumber
        set incsearch
        set hlsearch
        set ignorecase
        set smartcase

        set scrolloff 4
      ''
    ];
  };
}
