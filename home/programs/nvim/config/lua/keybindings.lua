-- [[key bindings]] --

local utils = require("utils")
vim.g.mapleader = " "

-- [basic mappings] --

utils.nnoremap(";", ":")
utils.vnoremap(";", ":")

utils.nnoremap("S", ":w<CR>")
utils.nmap("Q", function()
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

utils.nnoremap("<A-n>", "5<C-e>")
utils.nnoremap("<A-p>", "5<C-y>")
utils.xnoremap("<A-n>", "5<C-e>")
utils.xnoremap("<A-p>", "5<C-y>")
utils.inoremap("<A-h>", "<Left>")
utils.inoremap("<A-l>", "<Right>")

-- [searching] --

utils.nnoremap("N", "Nzz")
utils.nnoremap("n", "nzz")
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

utils.nnoremap("s", "<nop>")
utils.nnoremap("sl", ":set splitright<CR>:vsplit<CR>")
utils.nnoremap("sh", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>")
utils.nnoremap("sj", ":set splitbelow<CR>:split<CR>")
utils.nnoremap("sk", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>")

utils.nnoremap("gj", "<C-w>j")
utils.nnoremap("gk", "<C-w>k")
utils.nnoremap("gh", "<C-w>h")
utils.nnoremap("gl", "<C-w>l")

utils.nnoremap("<UP>", ":resize +5<CR>")
utils.nnoremap("<DOWN>", ":resize -5<CR>")
utils.nnoremap("<LEFT>", ":vertical resize-5<CR>")
utils.nnoremap("<RIGHT>", ":vertical resize+5<CR>")

utils.nnoremap("<leader>h", ":bp<CR>")
utils.nnoremap("<leader>l", ":bn<CR>")

-- [terminal behavior] --

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    command = "startinsert"
})

utils.tnoremap("<C-q>", [[<C-\><C-n>]])
utils.tnoremap("<C-o>", [[<C-\><C-n><C-o>]])
utils.tnoremap("<C-h>", [[<C-\><C-n><C-w>h]])
utils.tnoremap("<C-j>", [[<C-\><C-n><C-w>j]])
utils.tnoremap("<C-k>", [[<C-\><C-n><C-w>k]])
utils.tnoremap("<C-l>", [[<C-\><C-n><C-w>l]])

-- open kitty in cwd

utils.nnoremap("<leader>tt", function()
    os.execute("kitty&")
end)

-- [command mode cursor movement] --

utils.cnoremap("<C-a>", "<Home>")
utils.cnoremap("<C-e>", "<End>")
utils.cnoremap("<C-p>", "<Left>")
utils.cnoremap("<C-n>", "<Right>")

-- [other useful mappings] --

-- open fold
utils.nnoremap("<leader>o", "za", { silent = true })

-- select a line (no eol)
utils.nnoremap("vv", "0v$h")

-- replace next placeholder and insert
utils.nnoremap("<leader><leader>", "<ESC>/<++><CR>:nohl<CR>ca>", { silent = true })

-- toggle spellcheck
utils.nnoremap("<leader>sc", ":setlocal spell!<CR>", { silent = true })

-- toggle wrap
utils.nnoremap("<leader>wp", ":setlocal wrap!<CR>", { silent = true })

-- change case
utils.nnoremap("`", "~")

-- generate ascii figlet
utils.nnoremap("<leader>f", ":r !figlet ")

-- show cwd
utils.nnoremap("<leader>cd", ":echo getcwd()<CR>")

-- Move Lines
utils.nnoremap("<A-j>", "<cmd>m .+1<cr>==")
utils.nnoremap("<A-k>", "<cmd>m .-2<cr>==")
utils.inoremap("<A-j>", "<esc><cmd>m .+1<cr>==gi")
utils.inoremap("<A-k>", "<esc><cmd>m .-2<cr>==gi")
utils.vnoremap("<A-j>", ":m '>+1<cr>gv=gv")
utils.vnoremap("<A-k>", ":m '<-2<cr>gv=gv")

-- compile and run
utils.nnoremap("R", utils.compile_run)

-- open init.lua
utils.nnoremap("<leader>rc", ":e $MYVIMRC<CR>", { silent = true })

-- quick uppercase
utils.inoremap("<C-u>", "<ESC>mzgUiw`za")
utils.nnoremap("<C-u>", "mzgUiw`z")
