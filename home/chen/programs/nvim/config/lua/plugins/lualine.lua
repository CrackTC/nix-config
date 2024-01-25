local function get_left_most_circle_component()
    local function left_most_circle() return '' end
    return {
        left_most_circle,
        padding = 0,
        separator = { left = '', right = '' },
        color = { fg = '#2e3440', gui = "reverse" }
    }
end

local function get_filename_component()
    return {
        "filename",
        path = 0,
        padding = 0,
        file_status = true,
        newfile_status = true,
        color = { gui = "bold" },
        symbols = { modified = " ", readonly = " ", unnamed = "󰉩 nil", newfile = " " }
    }
end

local function get_git_branch_component()
    return { "branch", icon = '󰘬' }
end

local function get_file_format_component()
    return {
        "fileformat",
        color = { fg = "#d8dee9", },
        fmt = function(str) return "%=" .. str end,
        symbols = { unix = ' ', dos = '󰍲 ', mac = ' ', }
    }
end

local function get_file_encoding_component()
    return {
        'encoding',
        color = { fg = "#d8dee9" },
        cond = function() return vim.bo.fileencoding ~= 'utf-8' end
    }
end

local function get_diagnostics_component()
    return {
        "diagnostics",
        always_visible = true,
        update_in_insert = false,
        diagnostics_color = {
            error = { fg = '#bf616a' },
            warn  = { fg = '#d08770' },
            info  = { fg = '#8fbcbb' },
            hint  = { fg = '#a3be8c' },
        },
        sources = { "nvim_diagnostic", "coc" },
        symbols = { error = '󰝥 ', warn = '󰝥 ', info = '󰝥 ', hint = '󰝥 ', },
    }
end

local function get_file_type_component()
    return {
        "filetype",
        colored = false,
        color = { fg = "#d8dee9", }
    }
end

local function get_git_diff_component()
    return {
        "diff",
        symbols = { added = '+', modified = '~', removed = '-' },
        padding = 0
    }
end

local function get_location_component()
    return {
        'location',
        icon = '󰍍',
        padding = 0,
        color = { gui = "bold", },
        separator = { left = ' ', right = '' }
    }
end

local function get_right_most_circle_component()
    local function right_most_circle() return '' end
    return {
        right_most_circle,
        padding = 0,
        separator = { left = '', right = '' },
        color = { fg = '#2e3440', gui = "reverse" }
    }
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "neoclide/coc.nvim" },
    config = function()
        require('lualine').setup({
            options = {
                theme = "nord",
                globalstatus = true,
                section_separators = { left = '', right = '' },
                component_separators = { left = '·', right = '·' },
            },
            sections = {
                lualine_a = {
                    get_left_most_circle_component(),
                    get_filename_component()
                },
                lualine_b = {
                    get_git_branch_component()
                },
                lualine_c = {
                    get_file_format_component(),
                    get_file_encoding_component(),
                    get_diagnostics_component(),
                    get_file_type_component(),
                },
                lualine_x = {
                    get_git_diff_component()
                },
                lualine_y = {},
                lualine_z = {
                    get_location_component(),
                    get_right_most_circle_component()
                }
            }
        })
    end
}
