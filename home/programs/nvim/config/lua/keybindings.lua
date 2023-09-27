-- [[key bindings]] --

local utils = require("utils")
vim.g.mapleader = " "

-- [basic mappings] --

utils.noremap("", ";", "p")
utils.noremap("", "d", "g")
utils.noremap("", "f", "e")
utils.noremap("", "g", "t")
utils.noremap("", "j", "y")
utils.noremap("", "l", "u")
utils.noremap("", "o", ":")
utils.noremap("", "p", "r")
utils.noremap("", "r", "s")
utils.noremap("", "t", "f")
utils.noremap("", "u", "i")

utils.noremap("n", "N", "J")
utils.noremap("n", "E", "K")
utils.noremap("n", "I", "L")
utils.noremap("", ":", "P")
utils.noremap("", "D", "G")
utils.noremap("", "F", "E")
utils.noremap("", "G", "T")
utils.noremap("", "J", "Y")
utils.noremap("", "L", "U")
utils.noremap("", "O", ":")
utils.noremap("", "P", "R")
utils.noremap("", "R", "S")
utils.noremap("", "S", "D")
utils.noremap("", "T", "F")
utils.noremap("", "U", "I")
utils.noremap("", "Y", "O", { nowait = true })


utils.nnoremap("o", ":")
utils.vnoremap("o", ":")

utils.nnoremap("R", ":w<CR>")
utils.nnoremap("Q", function()
    local windows = vim.api.nvim_list_wins()

    local window_count = 0
    for _, window in pairs(windows) do
        if vim.api.nvim_win_get_config(window).relative == "" then
            window_count = window_count + 1
        end
    end

    if window_count > 1 then
        return ":q<CR>"
    end

    local output = vim.api.nvim_exec2("ls", { output = true }).output
    local buffer_count = #(vim.split(output, "\n"))

    if buffer_count > 1 then
        return ":bd<CR>"
    end

    return ":q<CR>"
end, { expr = true, silent = true })

utils.nnoremap("<A-k>", "5<C-e>")
utils.nnoremap("<A-;>", "5<C-y>")
utils.xnoremap("<A-k>", "5<C-e>")
utils.xnoremap("<A-;>", "5<C-y>")
utils.inoremap("<A-k>", "<Left>")
utils.inoremap("<A-;>", "<Right>")

-- [searching] --

utils.nnoremap("K", "Nzz")
utils.nnoremap("k", "nzz")
utils.nnoremap("<leader><CR>", ":nohlsearch<CR>", { silent = true })
utils.cnoremap("<CR>", function()
    local cmdtype = vim.fn.getcmdtype()
    if cmdtype == "/" or cmdtype == "?" then
        return "<CR>zz"
    else
        return "<CR>"
    end
end, { expr = true })

-- [window management] --

utils.nnoremap("r", "<nop>")
utils.nnoremap("ri", ":set splitright<CR>:vsplit<CR>")
utils.nnoremap("rh", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>")
utils.nnoremap("rn", ":set splitbelow<CR>:split<CR>")
utils.nnoremap("re", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>")

utils.nnoremap("dn", "<C-w>j")
utils.nnoremap("de", "<C-w>k")
utils.nnoremap("dh", "<C-w>h")
utils.nnoremap("di", "<C-w>l")

utils.nnoremap("<UP>", ":resize +5<CR>")
utils.nnoremap("<DOWN>", ":resize -5<CR>")
utils.nnoremap("<LEFT>", ":vertical resize-5<CR>")
utils.nnoremap("<RIGHT>", ":vertical resize+5<CR>")

utils.nnoremap("<leader>h", ":bp<CR>")
utils.nnoremap("<leader>i", ":bn<CR>")

-- [terminal behavior] --

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    command = "startinsert"
})

utils.tnoremap("<C-q>", [[<C-\><C-n>]])
utils.tnoremap("<C-y>", [[<C-\><C-n><C-o>]])
utils.tnoremap("<C-h>", [[<C-\><C-n><C-w>h]])
utils.tnoremap("<C-n>", [[<C-\><C-n><C-w>j]])
utils.tnoremap("<C-e>", [[<C-\><C-n><C-w>k]])
utils.tnoremap("<C-i>", [[<C-\><C-n><C-w>l]])

-- open kitty in cwd

utils.nnoremap("<leader>gg", function()
    os.execute("kitty&")
end)

-- [command mode cursor movement] --

utils.cnoremap("<C-a>", "<Home>")
utils.cnoremap("<C-f>", "<End>")
utils.cnoremap("<C-;>", "<Left>")
utils.cnoremap("<C-k>", "<Right>")

-- [other useful mappings] --

-- open fold
utils.nnoremap("<leader>y", "za", { silent = true })

-- select a line (no eol)
utils.nnoremap("vv", "0v$h")

-- replace next placeholder and insert
utils.nnoremap("<leader><leader>", "<ESC>/<++><CR>:nohl<CR>ca>", { silent = true })

-- toggle spellcheck
utils.nnoremap("<leader>rc", ":setlocal spell!<CR>", { silent = true })

-- toggle wrap
utils.nnoremap("<leader>w;", ":setlocal wrap!<CR>", { silent = true })

-- change case
-- utils.nnoremap("`", "~")

-- generate ascii figlet
utils.nnoremap("<leader>t", ":r !figlet ")

-- show cwd
utils.nnoremap("<leader>cs", ":echo getcwd()<CR>")

-- Move Lines
utils.nnoremap("<A-n>", "<cmd>m .+1<cr>==")
utils.nnoremap("<A-e>", "<cmd>m .-2<cr>==")
utils.inoremap("<A-n>", "<esc><cmd>m .+1<cr>==gi")
utils.inoremap("<A-e>", "<esc><cmd>m .-2<cr>==gi")
utils.vnoremap("<A-n>", ":m '>+1<cr>gv=gv")
utils.vnoremap("<A-e>", ":m '<-2<cr>gv=gv")

-- compile and run
utils.nnoremap("P", utils.compile_run)

-- open init.lua
utils.nnoremap("<leader>pc", ":e $MYVIMRC<CR>", { silent = true })

-- quick uppercase
utils.inoremap("<C-l>", "<ESC>mzgUiw`za")
utils.nnoremap("<C-l>", "mzgUiw`z")
