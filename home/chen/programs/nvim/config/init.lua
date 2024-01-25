require("settings")
require("plugin")
require("keybindings")
require("filetype")

if vim.fn.exists("g:neovide") then
    require("neovide")
end

