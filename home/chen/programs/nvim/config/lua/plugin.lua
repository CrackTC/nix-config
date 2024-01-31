-- [[plugins]] --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.fn.isdirectory(lazypath) then
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
        require("plugins.copilot"),
        require("plugins.csharpls-extended-lsp"),
        require("plugins.flit"),
        require("plugins.gitsigns"),
        require("plugins.headlines"),
        require("plugins.hlchunk"),
        require("plugins.illuminate"),
        require("plugins.img-paste"),
        require("plugins.joshuto"),
        require("plugins.lsp-signature"),
        require("plugins.lualine"),
        require("plugins.mardown-preview"),
        require("plugins.matchup"),
        require("plugins.nord"),
        require("plugins.notify"),
        require("plugins.repeat"),
        require("plugins.subversive"),
        require("plugins.surround"),
        require("plugins.tabular"),
        require("plugins.telescope"),
        require("plugins.treesitter"),
        require("plugins.undotree"),
        require("plugins.visual-multi"),
        require("plugins.wildfire"),
    },
    { ui = { border = "rounded" } }
)
