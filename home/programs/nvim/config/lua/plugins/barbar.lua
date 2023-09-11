local M = {}

local function setup_plugin()
    require("barbar").setup({
        tabpages = false,
        animation = false,
        auto_hide = true,
        clickable = true,
        exclude_ft = {},
        exclude_name = { "undotree_2", "diffpanel_3" },
        focus_on_close = 'left',
        highlight_visible = true, -- highlight all buffers in split window
        highlight_alternate = false,
        highlight_inactive_file_icons = false,
        hide = { extensions = false, inactive = false, alternate = false, current = false, visible = false, },
        icons = {
            buffer_index = false,
            buffer_number = false,
            -- button = '󰅖',
            button = '',
            diagnostics = {
                [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
                [vim.diagnostic.severity.WARN] = { enabled = false },
                [vim.diagnostic.severity.INFO] = { enabled = false },
                [vim.diagnostic.severity.HINT] = { enabled = true },
            },
            gitsigns = {
                added = { enabled = true, icon = '+' },
                changed = { enabled = true, icon = '~' },
                deleted = { enabled = true, icon = '-' },
            },
            filetype = { custom_colors = "Normal", enabled = true },

            separator = { left = '', right = '' },
            separator_at_end = false,

            modified = { button = '', separator = { left = '', right = '' } },
            pinned   = { button = '', filename  = true, separator = { left ='', right = '' } },

            current  = { separator = { left = '', right = '' } },
            inactive = { separator = { left = '', right = '' } },
            visible  = { separator = { left = '', right = '' } },
        },
        insert_at_start = false,
        insert_at_end = true,
        maximum_padding = 1000,
        semantic_letters = true,
        sidebar_filetypes = { undotree = { text = 'undotree' }, coctree = { text = "coctree" } },
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
        no_name_title = "[zzz]",
    })
end

local function setup_highlights()
    vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = "#3b4252", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "BufferCurrentADDED", { fg = "#a3be8c", bg = "#3b4252", })
    vim.api.nvim_set_hl(0, "BufferCurrentCHANGED", { fg = "#ebcb8b", bg = "#3b4252", })
    vim.api.nvim_set_hl(0, "BufferCurrentDELETED", { fg = "#bf616a", bg = "#3b4252", })

    vim.api.nvim_set_hl(0, "BufferInactiveSign", { fg = "#2e3440", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "BufferInactiveADDED", { fg = "#a3be8c", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "BufferInactiveCHANGED", { fg = "#ebcb8b", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "BufferInactiveDELETED", { fg = "#bf616a", bg = "#2e3440", })

    vim.api.nvim_set_hl(0, "BufferVisible", { fg = "#d8dee9", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "BufferVisibleIcon", { fg = "#d8dee9", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "BufferVisibleSign", { fg = "#2e3440", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "BufferVisibleADDED", { fg = "#a3be8c", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "BufferVisibleCHANGED", { fg = "#ebcb8b", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "BufferVisibleDELETED", { fg = "#bf616a", bg = "#2e3440", })
end

function M.config()
    setup_plugin()
    setup_highlights()
end

return M
