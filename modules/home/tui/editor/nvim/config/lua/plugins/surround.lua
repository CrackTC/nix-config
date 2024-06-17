local utils = require("utils")

local map_surrounds = function(from, to)
    -- add surrounds
    utils.xmap("s" .. from, "S" .. to)

    -- select surrounds
    utils.xnoremap("u" .. from, "i" .. to)
    utils.xnoremap("a" .. from, "a" .. to)
    utils.omap("u" .. from, "i" .. to)

    if from ~= to then
        utils.omap("a" .. from, "a" .. to)

        -- remove surrounds
        utils.nmap("sr" .. from, "sr" .. to)
    end
end

return {
    "tpope/vim-surround",
    config = function()
        utils.nnoremap("sr", "<Plug>Dsurround")

        local maps = {
            ["{"] = "}",
            ["["] = "]",
            ["t"] = "t",
        }

        for from, to in pairs(maps) do map_surrounds(from, to) end
    end
}
