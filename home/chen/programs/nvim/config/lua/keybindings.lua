-- [[key bindings]] --

local utils = require("utils")

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
utils.noremap("", "u", "i")

utils.noremap("n", "N", "J")
utils.noremap("n", "E", "K")
utils.noremap("n", "I", "L")
utils.noremap("", ":", "P")
utils.noremap("", "D", "G")
utils.noremap("", "F", "E")
utils.noremap("", "G", "T")
utils.noremap("", "J", "y$")
utils.noremap("", "L", "U")
utils.noremap("", "O", ":")
utils.noremap("", "P", "R")
utils.noremap("", "R", "S")
utils.noremap("", "S", "D")
utils.noremap("", "U", "I")
utils.noremap("", "Y", "O", { nowait = true })


utils.nnoremap("o", ":")
utils.xnoremap("o", ":")

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
utils.noremap({ "n", "t" }, "<A-o>", utils.open_term)

-- open kitty in cwd

utils.nnoremap("<leader>gg", function()
    os.execute("kitty&")
end)

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

-- generate ascii figlet
utils.nnoremap("<leader>t", ":r !figlet ")

-- show cwd
utils.nnoremap("<leader>cs", ":echo getcwd()<CR>")

-- Move Lines
utils.nnoremap("<A-n>", "<cmd>m .+1<cr>==")
utils.nnoremap("<A-e>", "<cmd>m .-2<cr>==")
utils.inoremap("<A-n>", "<esc><cmd>m .+1<cr>==gi")
utils.inoremap("<A-e>", "<esc><cmd>m .-2<cr>==gi")
utils.xnoremap("<A-n>", ":m '>+1<cr>gv=gv")
utils.xnoremap("<A-e>", ":m '<-2<cr>gv=gv")

-- compile and run
utils.nnoremap("P", utils.compile_run)

-- open init.lua
utils.nnoremap("<leader>pc", ":e $MYVIMRC<CR>", { silent = true })

-- quick uppercase
utils.inoremap("<C-l>", "<ESC>mzgUiw`za")
utils.nnoremap("<C-l>", "mzgUiw`z")

-- hjkl movement
utils.noremap("", "h", "h")
utils.noremap("", "n", "j")
utils.noremap("", "e", "k")
utils.noremap("", "i", "l", { nowait = true })

utils.noremap("", "s", "d")
utils.noremap("", "y", "o", { nowait = true })
utils.noremap("", "dd", "gg")
utils.noremap("", "dt", "gf")
utils.noremap("", "dx", "gx")

utils.xnoremap("s", "d", { nowait = true })

-- lsp
utils.nnoremap("sc", vim.lsp.buf.hover)
utils.nnoremap("sm", function()
    vim.lsp.buf.format()
    vim.diagnostic.enable(vim.api.nvim_get_current_buf())
end)
utils.nnoremap("ds", vim.lsp.buf.definition)
utils.nnoremap("dp", vim.lsp.buf.references)
utils.nnoremap("du", vim.lsp.buf.implementation)
utils.nnoremap("pk", vim.lsp.buf.rename)
utils.nnoremap("sh", vim.diagnostic.goto_prev)
utils.nnoremap("si", vim.diagnostic.goto_next)
utils.nnoremap("<leader>cl", vim.lsp.codelens.run)


utils.nnoremap("<C-p>", "<C-r>")

utils.nnoremap("p", "<Plug>(SubversiveSubstitute)", { silent = true });
