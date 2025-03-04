-- [[plugins]] --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.fn.isdirectory(lazypath) == 0 then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        require("plugins.actions-preview"),
        require("plugins.autopairs"),
        require("plugins.bufferline"),
        require("plugins.bullets"),
        require("plugins.cmp"),
        require("plugins.comment"),
        -- require("plugins.copilot"),
        require("plugins.csharpls-extended-lsp"),
        require("plugins.flit"),
        require("plugins.gitsigns"),
        require("plugins.render-markdown"),
        require("plugins.illuminate"),
        require("plugins.img-paste"),
        require("plugins.lsp-signature"),
        require("plugins.lualine"),
        require("plugins.mardown-preview"),
        require("plugins.matchup"),
        require("plugins.nord"),
        require("plugins.notify"),
        require("plugins.null-ls"),
        require("plugins.repeat"),
        require("plugins.subversive"),
        require("plugins.surround"),
        require("plugins.tabular"),
        require("plugins.telescope"),
        require("plugins.treesitter"),
        require("plugins.undotree"),
        require("plugins.vim-sleuth"),
        require("plugins.visual-multi"),
        require("plugins.wildfire"),
        require("plugins.yazi"),
    },
    { ui = { border = "rounded" } }
)
