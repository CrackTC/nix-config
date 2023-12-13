local M = {}

local function setup_variables()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

function M.config()
    setup_variables()
end

return M
