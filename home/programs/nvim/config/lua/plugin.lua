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
print(lazypath)

require("lazy").setup({
        {
            "shaunsingh/nord.nvim",
            priority = 1000,
            config = require("plugins.nord").config
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = require("plugins.treesitter").config
        },
        {
            "lukas-reineke/headlines.nvim",
            dependencies = { "nvim-treesitter/nvim-treesitter" },
            ft = { "markdown" },
            config = require("plugins.headlines").config
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons", "neoclide/coc.nvim", "shaunsingh/nord.nvim" },
            config = require("plugins.lualine").config
        },
        {
            "romgrk/barbar.nvim",
            dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons", },
            init = function() vim.g.barbar_auto_setup = false end,
            config = require("plugins.barbar").config
        },
        {
            "lewis6991/gitsigns.nvim",
            config = require("plugins.gitsigns").config
        },
        {
            "dkarter/bullets.vim",
            ft = { "text", "markdown", "gitcommit", "scratch" }
        },
        {
            "mbbill/undotree",
            cmd = { "UndotreeToggle" },
            init = require("plugins.undotree").config,
        },
        {
            "iamcco/markdown-preview.nvim",
            ft = { "markdown" },
            build = function() vim.fn["mkdp#util#install"]() end
        },
        {
            "tpope/vim-surround",
            config = require("plugins.surround").config
        },
        {
            "tpope/vim-repeat"
        },
        {
            "numToStr/Comment.nvim",
            config = require("plugins.comment").config
        },
        {
            "mg979/vim-visual-multi",
            branch = "master",
            keys = { { "<C-n>", nil } },
            config = require("plugins.visual-multi").config
        },
        {
            "andymass/vim-matchup",
            config = require("plugins.matchup").config
        },
        {
            "RRethy/vim-illuminate",
            config = require("plugins.illuminate").config
        },
        {
            "theniceboy/joshuto.nvim",
            keys = { { "<leader>ra", function() require("joshuto").joshuto() end } }
        },
        {
            "godlygeek/tabular",
            cmd = "Tabularize",
            init = require("plugins.tabular").config
        },
        {
            "svermeulen/vim-subversive",
            config = require("plugins.subversive").config
        },
        {
            "github/copilot.vim",
            build = function()
                vim.cmd([[Copilot setup]])
            end,
            init = require("plugins.copilot").config
        },
        {
            "neoclide/coc.nvim",
            branch = "release",
            config = require("plugins.coc").config
        },
        {
            "shellRaining/hlchunk.nvim",
            event = { "UIEnter" },
            config = require("plugins.hlchunk").config
        },
        {
            "rcarriga/nvim-notify",
            config = require("plugins.notify").config
        },
        {
            "ggandor/flit.nvim",
            dependencies = { "ggandor/leap.nvim" },
            config = require("plugins.flit").config
        },
        {
            "img-paste-devs/img-paste.vim",
            ft = { "markdown" },
            config = require("plugins.img-paste").config
        }
    },
    { ui = { border = "rounded" } }
)
