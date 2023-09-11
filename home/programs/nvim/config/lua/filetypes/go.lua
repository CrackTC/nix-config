-- [[go settings]] --

require("utils").on_filetype("go", function()
    vim.opt_local.expandtab = false
    vim.b.coc_pairs_disabled = { "<", "'" }
end)
