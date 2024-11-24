require("settings")
require("plugin")
require("keybindings")
require("filetype")
require("lsp")

if vim.fn.exists("g:neovide") then
    require("neovide")
end
