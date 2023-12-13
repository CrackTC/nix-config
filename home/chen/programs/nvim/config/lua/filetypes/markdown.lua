-- [[markdown settings]] --

local utils = require("utils")

local function apply_markdown_mappings()
    utils.buffered_inoremap(",f", "<ESC>/<++><CR>:nohl<CR>ca>")
    utils.buffered_inoremap(",b", "**** <++><ESC>2F*i")
    utils.buffered_inoremap(",i", "** <++><ESC>F*i")
    utils.buffered_inoremap(",w", "****** <++><ESC>3F*i")
    utils.buffered_inoremap(",d", "`` <++><ESC>F`i")
    utils.buffered_inoremap(",c", "```<CR><++><CR>```<CR><++><ESC>4kA")
    utils.buffered_inoremap(",s", "~~~~ <++><ESC>2F~i")
    utils.buffered_inoremap(",p", "![](<++>) <++><ESC>F]i")
    utils.buffered_inoremap(",a", "[](<++>) <++><ESC>F]i")
    utils.buffered_inoremap(",l", "--------<CR>")
    utils.buffered_inoremap(",m", "- [ ]")
    utils.buffered_inoremap(",1", "#<SPACE><CR><++><ESC>kA")
    utils.buffered_inoremap(",2", "##<SPACE><CR><++><ESC>kA")
    utils.buffered_inoremap(",3", "###<SPACE><CR><++><ESC>kA")
    utils.buffered_inoremap(",4", "####<SPACE><CR><++><ESC>kA")
    utils.buffered_inoremap(",5", "#####<SPACE><CR><++><ESC>kA")
    utils.buffered_inoremap(",6", "######<SPACE><CR><++><ESC>kA")
end

utils.on_filetype("markdown", function()
    apply_markdown_mappings()
    -- vim.opt_local.spell = true
    vim.opt_local.wrap = false
end)
