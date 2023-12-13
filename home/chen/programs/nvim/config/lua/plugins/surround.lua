local M = {}

local utils = require("utils")

local map_surrounds = function(from, to)
    -- add surrounds
    utils.xmap("s" .. from, "S" .. to)

    -- select surrounds
    utils.xnoremap("u" .. from, "i" .. to)
    utils.xnoremap("a" .. from, "a" .. to)
    utils.omap("u" .. from, "i" .. to)
    utils.omap("a" .. from, "a" .. to)

    -- remove surrounds
    utils.nmap("sr" .. from, "sr" .. to)
end

local function setup_mappings()
    local maps = {
        ["H"] = '"',
        ["h"] = "'",
        ["l"] = ")",
        ["{"] = "}",
        ["["] = "]",
        ["t"] = "t",
    }

    utils.nnoremap("sr", "<Plug>Dsurround")
    for from, to in pairs(maps) do map_surrounds(from, to) end
end

function M.config()
    setup_mappings()
end

return M
