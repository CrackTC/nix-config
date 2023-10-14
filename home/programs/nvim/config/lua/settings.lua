-- [[main settings for neovim]] --

local utils = require("utils")

vim.opt.mouse = "a"                     -- disable mouse
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.fileencodings = {
    "ucs-bom",
    "utf-8",
    "default",
    "gbk",
    "latin1",
}

-- [editor behavior] --

vim.opt.number = true         -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.signcolumn = "yes:1"  -- always show sign column
vim.opt.cursorline = true     -- highlight current line
vim.opt.hlsearch = false      -- highlight search results
vim.opt.ruler = true          -- show cursor position
vim.opt.expandtab = true      -- use spaces instead of tabs
vim.opt.tabstop = 4           -- tab size, number of spaces
vim.opt.shiftwidth = 4        -- indent size, number of spaces, used for >>, <<, ==, etc.
vim.opt.autoindent = true     -- copy indent from current line when starting a new line
vim.opt.list = true           -- show whitespace characters
vim.opt.listchars = {
    lead = "─",
    tab = "<->",
    trail = "·"
}
vim.opt.scrolloff = 4         -- minimum number of lines to keep above and below cursor
vim.opt.wrap = false          -- don't wrap lines
vim.opt.linebreak = false     -- wrap long lines at characters in 'breakat'
vim.opt.timeoutlen = 1000     -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.textwidth = 0         -- don't wrap lines

vim.opt.foldenable = true     -- enable folding
vim.opt.foldmethod = "indent" -- fold based on indent
vim.opt.foldlevel = 99        -- open all folds by default

vim.opt.showmode = false      -- don't show mode
vim.opt.hidden = true         -- allow switching between buffers without saving
vim.opt.showcmd = true        -- show command in bottom bar
vim.opt.wildmenu = true       -- show completion menu
vim.opt.ignorecase = true     -- ignore case when searching
vim.opt.smartcase = true      -- ignore case when searching lowercase, but not when searching uppercase
vim.opt.shortmess:append("c") -- don't show completion messages
vim.opt.inccommand = "split"  -- quick preview while replacing words
vim.opt.completeopt = {
    "longest",
    "noinsert",
    "menuone",
    "noselect",
    "preview",
}                             -- build-in completion config
vim.opt.lazyredraw = true     -- don't redraw while executing macros
vim.opt.virtualedit = "block" -- allow cursor to move anywhere in visual block mode
vim.opt.cmdheight = 1

-- [backup] --

local backupdir = vim.fn.expand("$HOME/.local/state/nvim/tmp")
utils.ensure_dir_exists(backupdir)

local undodir = vim.fn.expand("$HOME/.local/state/nvim/tmp/undo")
utils.ensure_dir_exists(undodir)

vim.opt.backupdir = {
    backupdir,
    ".",
}

vim.opt.directory = {
    backupdir,
    ".",
}

if vim.fn.has("persistent_undo") then
    vim.opt.undofile = true
    vim.opt.undodir = {
        undodir,
        ".",
    }
end

vim.opt.updatetime = 90 -- time to wait for a mapped sequence to complete (in milliseconds)

-- [recover cursor position] --

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = '*',
    callback = function()
        local ft = vim.opt_local.filetype:get()
        -- don't apply to git messages
        if (ft:match('commit') or ft:match('rebase')) then
            return
        end
        -- get position of last saved edit
        local markpos = vim.api.nvim_buf_get_mark(0, '"')
        local line = markpos[1]
        local col = markpos[2]
        -- if in range, go there
        if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
            vim.api.nvim_win_set_cursor(0, { line, col })
        end
    end
})
