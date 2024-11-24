-- [[cpp settings]] --

require('utils').on_filetype("cpp", function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 2
end)
