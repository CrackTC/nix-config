local utils = require("utils")

return {
    "dkarter/bullets.vim",
    ft = { "text", "markdown", "gitcommit", "scratch" },
    init = function()
        vim.g.bullets_set_mappings = 0
        utils.on_filetype("markdown", function()
            utils.buffered_imap("<cr>", "<Plug>(bullets-newline)")
            utils.buffered_inoremap("<C-cr>", "<cr>")
            utils.buffered_nmap("y", "<Plug>(bullets-newline)", { nowait = true })
            utils.buffered_nmap(">>", "<Plug>(bullets-demote)")
            utils.buffered_nmap("<<", "<Plug>(bullets-promote)")
            utils.buffered_vmap(">", "<Plug>(bullets-demote)")
            utils.buffered_vmap("<", "<Plug>(bullets-promote)")
            utils.buffered_nmap("<leader>x", "<Plug>(bullets-toggle-checkbox)")
        end)
    end
}
