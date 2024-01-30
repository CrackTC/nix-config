local utils = require("utils")

local function on_tab()
    local cmp = require("cmp")
    if cmp.visible() then
        cmp.confirm({ select = true })
    elseif vim.fn["vsnip#available"](1) == 1 then
        return "<Plug>(vsnip-expand-or-jump)"
    else
        return "<Tab>"
    end
end

local function on_s_tab()
    if vim.fn["vsnip#jumpable"](-1) == 1 then
        return "<Plug>(vsnip-jump-prev)"
    else
        return "<S-Tab>"
    end
end

local function select_prev_item()
    local cmp = require("cmp")
    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
end

local function select_next_item()
    local cmp = require("cmp")
    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
end

local function float_scroll_up() require("cmp").scroll_docs(-5) end
local function float_scroll_down() require("cmp").scroll_docs(5) end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- vsnip
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-vsnip",

        -- lsp
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",

        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",

        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local opts = { nowait = true, silent = true, expr = true }
        local lspkind = require("lspkind")

        utils.inoremap("<Tab>", on_tab, opts)
        utils.snoremap("<Tab>", on_tab, opts)
        utils.cnoremap("<Tab>", on_tab, opts)

        utils.inoremap("<S-Tab>", on_s_tab, opts)
        utils.snoremap("<S-Tab>", on_s_tab, opts)

        utils.inoremap("<C-k>", select_next_item)
        utils.cnoremap("<C-k>", select_next_item)
        utils.inoremap("<C-;>", select_prev_item)
        utils.cnoremap("<C-;>", select_prev_item)

        utils.inoremap("<C-n>", float_scroll_down)
        utils.inoremap("<C-e>", float_scroll_up)

        utils.inoremap("<C-Space>", require("cmp").complete)
        utils.cnoremap("<C-Space>", require("cmp").complete)

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noinsert"
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "…",
                    show_labelDetails = true,
                })
            },
            mapping = {},
            snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp" },
                    { name = "vsnip" }
                },
                {
                    { name = "buffer" }
                }
            ),
            window = {
                completion = {
                    border = "rounded",
                    scrollbar = false
                },
                documentation = { border = "rounded" }
            }
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = {},
            sources = {
                { name = "buffer" }
            }
        })

        cmp.setup.cmdline(':', {
            mapping = {},
            sources = cmp.config.sources(
                {
                    { name = "path" }
                },
                {
                    { name = "cmdline" }
                }
            )
        })

        vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#8fbcbb", fg = "#2e3440" })
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
    end
}
