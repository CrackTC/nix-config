require("settings")
require("keybindings")
require("plugin")
require("filetype")

if vim.fn.exists("g:neovide") then
    require("neovide")
end

