local function setup_mappings(_)
    local gitsigns = package.loaded.gitsigns
    local utils = require("utils")

    utils.buffered_nnoremap('d;', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    utils.buffered_nnoremap('dk', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.next_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    utils.buffered_nnoremap('<leader>d', gitsigns.preview_hunk)
end

local function setup_highlights()
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#d08770" })
    vim.api.nvim_set_hl(0, "GitSignsAddPreview", { fg = "#a3be8c" })
    vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { fg = "#bf616a" })
end

return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add          = { text = '+' },
                change       = { text = '~' },
                changedelete = { text = '*' },
                untracked    = { text = '┆' },
                delete       = { text = '-' },
                topdelete    = { text = '^' },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 1000,
                ignore_whitespace = true,
            },
            current_line_blame_formatter = '<author>|<author_time:%Y-%m-%d>|<summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,
            max_file_length = 40000, -- in lines
            preview_config = {
                border = 'rounded',
                style = 'minimal',
                relative = 'cursor',
                height = 15,
                row = 1,
                col = 1,
            },
            yadm = { enable = false },
            on_attach = setup_mappings
        })

        setup_highlights()
    end
}
