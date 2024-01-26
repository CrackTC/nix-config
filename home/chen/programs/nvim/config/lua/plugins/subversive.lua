return {
    "svermeulen/vim-subversive",
    config = function()
        local utils = require("utils")

        utils.nmap("r", "<Plug>(SubversiveSubstitute)")
        utils.nmap("rr", "<Plug>(SubversiveSubstituteLine)")
    end
}
