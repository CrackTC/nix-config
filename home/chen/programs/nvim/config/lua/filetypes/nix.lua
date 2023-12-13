-- [[nix settings]] --

require('utils').on_filetype("nix", function ()
    vim.opt_local.shiftwidth = 2
end)
