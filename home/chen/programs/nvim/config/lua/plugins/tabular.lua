local M = {}

local function setup_mappings()
    local utils = require("utils")
    utils.xnoremap("A", ":Tabularize /")
end

function M.config()
    setup_mappings()
end

return M
