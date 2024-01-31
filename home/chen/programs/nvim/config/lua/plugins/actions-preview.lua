return {
    "aznhe21/actions-preview.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
        { "<leader>a", function() require("actions-preview").code_actions() end, desc = "CodeAction" }
    },
    config = function()
        require("actions-preview").setup {
            diff = { ctxlen = 10 },
            backend = { "telescope" },
            telescope = vim.tbl_extend(
                "force",
                require("telescope.themes").get_dropdown(),
                {
                    make_value = nil,
                    make_make_display = nil,
                }
            )
        }
    end
}
