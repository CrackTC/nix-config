-- [[post key bindings]] --

local utils = require("utils")

utils.noremap("", "n", "j")
utils.noremap("", "e", "k")
utils.noremap("", "i", "l", { nowait = true })

utils.noremap("", "s", "d")
utils.noremap("", "y", "o", { nowait = true })
utils.noremap("", "dd", "gg")

utils.vnoremap("s", "d", { nowait = true })
utils.nnoremap("ds", "<Plug>(coc-definition)", { silent = true })

utils.nnoremap("<C-p>", "<C-r>")