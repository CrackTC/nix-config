local M = {}

local function setup_plugin()
    require('Comment').setup(
        {
            toggler = {
                line = "dcc",
                block = "dbc"
            },
            opleader = {
                line = "dc",
                block = "db"
            },
            mappings = {
                basic = true,
                extra = false
            }
        }
    )
end

function M.config()
    setup_plugin()
end

return M
