return {
    "dkarter/bullets.vim",
    ft = { "text", "markdown", "gitcommit", "scratch" },
    init = function()
        vim.g.bullets_set_mappings = 0
        vim.g.bullets_custom_mappings = {
            { "imap",     "<cr>",      "<Plug>(bullets-newline)" },
            { "inoremap", "<C-cr>",    "<cr>" },
            { "nmap",     "y",         "<Plug>(bullets-newline)" },
            { "nmap",     ">>",        "<Plug>(bullets-demote)" },
            { "nmap",     "<<",        "<Plug>(bullets-promote)" },
            { "vmap",     ">",         "<Plug>(bullets-demote)" },
            { "vmap",     "<",         "<Plug>(bullets-promote)" },
            { "nmap",     "<leader>x", "<Plug>(bullets-toggle-checkbox)" }
        }
    end
}
