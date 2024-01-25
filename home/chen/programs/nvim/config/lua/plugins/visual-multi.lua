local M = {}

local function setup_mappings()
    local maps = {
        ["Find Under"] = "<C-k>",
        ["Find Subword Under"] = "<C-k>"
    }
    vim.g.VM_default_mappings = 0
    vim.g.VM_maps = maps
end

function M.config()
    setup_mappings()
end

return M
