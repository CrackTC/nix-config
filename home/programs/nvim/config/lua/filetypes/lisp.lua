-- [[lisp settings]] --

require("utils").on_filetype("lisp", function()
    vim.b.coc_pairs_disabled = { "<", "'" }
end)
