local M = {}

local function setup_mappings()
    local utils = require("utils")

    utils.nmap("r", "<Plug>(SubversiveSubstitute)")
    utils.nmap("rr", "<Plug>(SubversiveSubstituteLine)")
    utils.nmap('<leader>rr', 'r$')
end

function M.config()
    setup_mappings()
end

return M
