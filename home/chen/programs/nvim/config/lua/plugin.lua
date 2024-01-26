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
        require("plugins.nord"),
        require("plugins.treesitter"),
        require("plugins.headlines"),
        require("plugins.bufferline"),
        require("plugins.lualine"),
        require("plugins.gitsigns"),
        require("plugins.bullets"),
        require("plugins.undotree"),
        require("plugins.mardown-preview"),
        require("plugins.surround"),
        require("plugins.repeat"),
        require("plugins.comment"),
        require("plugins.visual-multi"),
        require("plugins.matchup"),
        require("plugins.illuminate"),
        require("plugins.joshuto"),
        require("plugins.tabular"),
        require("plugins.subversive"),
        require("plugins.copilot"),
        require("plugins.coc"),
        require("plugins.hlchunk"),
        require("plugins.notify"),
        require("plugins.flit"),
        require("plugins.img-paste"),
    },
    { ui = { border = "rounded" } }
)
