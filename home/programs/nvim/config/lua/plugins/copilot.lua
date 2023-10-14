local M = {}

local function setup_variables()
    vim.g.copilot_filetypes = { markdown = true }
    vim.g.copilot_no_tab_map = true
end

local function setup_mappings()
    local utils = require("utils")
    utils.imap("<C-i>", 'copilot#Accept("")', {
        expr = true,
        silent = true,
        replace_keycodes = false
    })
end

function M.config()
    setup_variables()
    setup_mappings()
end

return M
