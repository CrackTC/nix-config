-- [[haskell settings]] --

require('utils').on_filetype({ "haskell", "lhaskell" }, function()
    vim.opt_local.shiftwidth = 2
end)
