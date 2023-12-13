local M = {}

local function setup_plugin()
    require("nord").set()
end

local function setup_variables()
    vim.g.nord_contrast = true
    vim.g.nord_borders = true
    vim.g.nord_disable_background = false
    vim.g.nord_cursorline_transparent = true
    vim.g.nord_enable_sidebar_background = false
    vim.g.nord_italic = true
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = true
end

local function setup_highlights()
    vim.opt.background = "dark"
    vim.api.nvim_set_hl(0, "NonText", { fg = "#434c5e", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#d8dee9", bg = "#2e3440", })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#d8dee9", bg = "#2e3440", })
end

function M.config()
    setup_variables()
    setup_plugin()
    setup_highlights()
end

return M
