local M = {}

local function setup_mappings()
    local utils = require("utils")
    utils.nnoremap("<leader>n", ":UndotreeToggle<CR>")
end

local function setup_variables()
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators    = 1
    vim.g.undotree_WindowLayout       = 2
    vim.g.undotree_DiffpanelHeight    = 8
    vim.g.undotree_SplitWidth         = 24
end

function M.config()
    setup_mappings()
    setup_variables()
end

return M
