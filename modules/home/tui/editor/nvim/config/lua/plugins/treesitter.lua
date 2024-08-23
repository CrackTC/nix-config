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
    "xml",
    "yaml"
}

local function setup_plugin()
    require('nvim-treesitter.configs').setup({
        ensure_installed = extensions,

        highlight = {
            enable = true,
            disable = function(_, buf)
                local max_filesize = 512 * 1024;
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end
        },
        indent = { enable = false },
        matchup = { enable = true },
    })
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

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        setup_variables()
        setup_plugin()
        setup_highlights()
    end
}
