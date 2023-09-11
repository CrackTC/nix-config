local M = {}

local function setup_mappings()
    local utils = require("utils")
    local opts = { buffer = true, silent = true }
    utils.nnoremap("<leader>p", ":call mdip#MarkdownClipboardImage()<CR>", opts)
end

local function setup_autocmds()
    local utils = require("utils")
    utils.on_filetype("markdown", setup_mappings)
end

function M.config()
    setup_autocmds()
    setup_mappings()
end

return M
