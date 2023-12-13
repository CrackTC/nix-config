local M = {}

local function setup_mappings()
    local maps = {
        ["Find Under"] = "<C-n>",
        ["Find Subword Under"] = "<C-n>"
    }
    vim.g.VM_maps = maps
end

function M.config()
    setup_mappings()
end

return M
