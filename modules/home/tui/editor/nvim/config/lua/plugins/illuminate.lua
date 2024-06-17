local function setup_plugin()
    require('illuminate').configure({
        providers = { 'lsp', 'treesitter' },
        delay = 100,
    })
end

local function setup_highlights()
    vim.cmd([[hi! IlluminatedWordText cterm=undercurl gui=undercurl]])
    vim.cmd([[hi! IlluminatedWordRead cterm=underdashed gui=underdashed]])
    vim.cmd([[hi! IlluminatedWordWrite cterm=underdouble gui=underdouble]])
end

return {
    "RRethy/vim-illuminate",
    config = function ()
        setup_plugin()
        setup_highlights()
    end
}
