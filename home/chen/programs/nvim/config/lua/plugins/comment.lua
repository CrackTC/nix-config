local M = {}

local function setup_plugin()
    require('Comment').setup()
end

function M.config()
    setup_plugin()
end

return M
