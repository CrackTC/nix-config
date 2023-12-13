local M = {}

local utils = require("utils")

local map_surrounds = function(from, to)
    -- add surrounds
    utils.xmap("s" .. from, "S" .. to)

    -- select surrounds
    utils.xnoremap("i" .. from, "i" .. to)
    utils.xnoremap("a" .. from, "a" .. to)
    utils.omap("i" .. from, "i" .. to)
    utils.omap("a" .. from, "a" .. to)

    -- remove surrounds
    utils.nmap("ds" .. from, "ds" .. to)
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

    for from, to in pairs(maps) do map_surrounds(from, to) end
end

function M.config()
    setup_mappings()
end

return M
