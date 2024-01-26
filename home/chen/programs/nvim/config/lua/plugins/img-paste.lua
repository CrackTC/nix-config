local function setup_mappings()
    local utils = require("utils")
    local opts = { buffer = true, silent = true }
    utils.nnoremap("<leader>;", ":call mdip#MarkdownClipboardImage()<CR>", opts)
end

local function setup_autocmds()
    local utils = require("utils")
    utils.on_filetype("markdown", setup_mappings)
end

return {
    "img-paste-devs/img-paste.vim",
    ft = { "markdown" },
    config = function()
        setup_autocmds()
        setup_mappings()
    end
}
