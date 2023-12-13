require("settings")
require("keybindings")
require("plugin")
require("post-keybindings")
require("filetype")

if vim.fn.exists("g:neovide") then
    require("neovide")
end

