local M = {}

local extensions = {
    "coc-clangd",
    "coc-css",
    "coc-gitignore",
    "coc-go",
    "coc-highlight",
    "coc-html",
    "coc-json",
    "coc-lua",
    "coc-marketplace",
    "coc-pairs",
    "coc-phpls",
    "coc-snippets",
    "coc-translator",
    "coc-tsserver",
    "coc-vimlsp",
    "coc-yaml",
}

local function setup_variables()
    vim.g.coc_global_extensions = extensions
end

local function setup_highlights()
    vim.cmd([[hi! CocMarkdownLink ctermfg=12 guifg=#8fbcbb]])
    vim.cmd([[hi! CocInlayHint    ctermfg=12 guifg=#616e88]])

    -- pum highlighting
    vim.cmd([[hi! CocFloating          ctermbg=8       guibg=None                           ]])
    vim.cmd([[hi! CocSearch            cterm=undercurl gui=undercurl ctermfg=2 guifg=#A3BE8C]])
    vim.cmd([[hi! CocMenuSel           ctermbg=14      guibg=#8fbcbb ctermfg=8 guifg=#2E3440]])
    vim.cmd([[hi! CocFloatThumb        ctermbg=7       guibg=#d8dee9 ctermfg=8 guifg=#2E3440]])
    vim.cmd([[hi! CocFloatSbar         ctermfg=8       guifg=#2E3440 ctermbg=8 guibg=#2E3440]])
    vim.cmd([[hi! CocFloatDividingLine ctermfg=7       guifg=#d8dee9                        ]])
end

local function setup_mappings()
    local function show_docs()
        local current_word = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
            vim.api.nvim_command('h ' .. current_word)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
            vim.fn.CocActionAsync('doHover')
        else
            vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. current_word)
        end
    end

    local function on_tab()
        if vim.fn["coc#pum#visible"]() == 1 then
            return vim.fn["coc#pum#confirm"]()
        elseif vim.fn["coc#expandableOrJumpable"]() then
            return "<Plug>(coc-snippets-expand-jump)"
        else
            return "<Tab>"
        end
    end

    local function on_enter() return "<C-g>u<CR><C-r>=coc#on_enter()<CR>" end
    local function on_ctrl_space() return vim.fn["coc#refresh"]() end

    local function float_scroll(forward, fallback)
        return function()
            if vim.fn["coc#float#has_scroll"]() == 1 then
                return vim.fn["coc#float#scroll"](forward)
            else
                return fallback
            end
        end
    end

    local function pum_select(next, fallback)
        return function()
            if vim.fn["coc#pum#visible"]() == 1 then
                if next == 1 then
                    return vim.fn["coc#pum#next"](1)
                else
                    return vim.fn["coc#pum#prev"](1)
                end
            else
                return fallback
            end
        end
    end

    local utils = require('utils')

    local opts = { silent = true, expr = true, nowait = true }
    utils.inoremap("<Tab>", on_tab, opts)
    utils.inoremap("<CR>", on_enter, opts)
    utils.inoremap("<C-Space>", on_ctrl_space, opts)

    utils.inoremap("<C-k>", pum_select(1, "<C-k>"), opts)
    utils.inoremap("<C-;>", pum_select(0, "<C-;>"), opts)

    opts = { silent = true }
    -- utils.nnoremap("ds", "<Plug>(coc-definition)", opts)
    utils.nnoremap("dj", "<Plug>(coc-type-definition)", opts)
    utils.nnoremap("du", "<Plug>(coc-implementation)", opts)
    utils.nnoremap("dp", "<Plug>(coc-references)", opts)
    utils.nnoremap("sh", "<Plug>(coc-diagnostic-prev)", opts)
    utils.nnoremap("si", "<Plug>(coc-diagnostic-next)", opts)
    utils.nnoremap("sm", "<Plug>(coc-format)", opts)
    utils.nnoremap("pk", "<Plug>(coc-rename)", opts)
    utils.nnoremap("<A-h>", "<Plug>(coc-float-hide)", opts)
    utils.nnoremap("<leader>a", "<Plug>(coc-codeaction-cursor)", opts)
    utils.nnoremap("<leader>ci", "<Plug>(coc-codelens-action)", opts)

    utils.inoremap("<C-n>", float_scroll(1, "<C-n>"), opts)
    utils.inoremap("<C-e>", float_scroll(0, "<C-e>"), opts)
    utils.nnoremap("<C-n>", float_scroll(1, "<C-n>"), opts)
    utils.nnoremap("<C-e>", float_scroll(0, "<C-e>"), opts)

    utils.nnoremap("sc", show_docs, opts)

    utils.xnoremap("ut", "<Plug>(coc-funcobj-i)")
    utils.xnoremap("at", "<Plug>(coc-funcobj-a)")
    utils.onoremap("ut", "<Plug>(coc-funcobj-i)")
    utils.onoremap("at", "<Plug>(coc-funcobj-a)")
    utils.xnoremap("uc", "<Plug>(coc-classobj-i)")
    utils.onoremap("uc", "<Plug>(coc-classobj-i)")
    utils.xnoremap("ac", "<Plug>(coc-classobj-a)")
    utils.onoremap("ac", "<Plug>(coc-classobj-a)")

    utils.nnoremap("<leader>gr", "<Plug>(coc-translator-p)", opts)
    utils.vnoremap("<leader>gr", "<Plug>(coc-translator-pv)", opts)
end

local function setup_autocmds()
    vim.api.nvim_create_augroup("CocGroup", {})
    vim.api.nvim_create_autocmd("User", {
        group = "CocGroup",
        pattern = "CocJumpPlaceholder",
        command = "call CocActionAsync('showSignatureHelp')",
        desc = "Update signature help on jump placeholder"
    })
end


function M.config()
    setup_variables()
    setup_highlights()
    setup_mappings()
    setup_autocmds()
end

return M
