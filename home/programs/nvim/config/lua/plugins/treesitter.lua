local M = {}

local extensions = {
    "bash",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "fish",
    "gitignore",
    "go",
    "haskell",
    "html",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nix",
    "python",
    "query",
    "scheme",
    "toml",
    "verilog",
    "vim",
    "vimdoc",
}

local function setup_plugin()
    require('nvim-treesitter.configs').setup({
        ensure_installed = extensions,

        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<BS>",
                scope_incremental = false,
            },
        },
        indent = { enable = false },
        matchup = { enable = true },
    })

    -- map xml to html parser
    vim.treesitter.language.register("html", "xml")
end

local function setup_variables()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()";
    vim.opt.foldenable = false -- Disable folding at startup.
end

local function setup_highlights()
    -- mainly for markdown
    vim.api.nvim_set_hl(0, "@text.emphasis", { italic = true, fg = "#88c0d0" })
    vim.api.nvim_set_hl(0, "@text.strong", { bold = true, fg = "#88c0d0" })
    vim.api.nvim_set_hl(0, "@text.strike", { strikethrough = true, fg = "#88c0d0" })
    vim.api.nvim_set_hl(0, "@text.literal", { link = "@punctuation.delimiter" })
    vim.api.nvim_set_hl(0, "@text.uri", { underline = true, fg = "#a3be8c" })
end

function M.config()
    setup_variables()
    setup_plugin()
    setup_highlights()
end

return M
