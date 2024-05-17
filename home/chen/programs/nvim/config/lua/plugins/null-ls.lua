return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup {
            sources = {
                null_ls.builtins.formatting.autopep8, -- python autopep8
                null_ls.builtins.diagnostics.statix   -- nix lints
            }
        }
    end
}
