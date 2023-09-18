-- [[c settings]] --

require('utils').on_filetype("c", function ()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 2
end)
