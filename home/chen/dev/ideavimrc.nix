{
  home.file.".ideavimrc".text = ''
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
    noremap o :
    noremap O :
    noremap R :w<CR>
    noremap K N
    noremap k n
    noremap Q :q<CR>
    noremap dd gg
    noremap d g

    nnoremap ds :action GotoDeclaration<CR>
    nnoremap dS :action GotoTypeDeclaration<CR>
    nnoremap sc K
    nnoremap <Space>a :action QuickActions<CR>
    noremap dc :action CommentByLineComment<CR>

    set number
    set relativenumber
    set incsearch
    set hlsearch
    set ignorecase
    set smartcase

    set scrolloff 4
  '';
}
