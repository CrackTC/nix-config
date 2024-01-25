return {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("nord").setup({
            transparent = true,
            terminal_colors = true,
            diff = { mode = "bg" },
            borders = true,
            errors = { mode = "bg" },
            search = { theme = "vim" },

            styles = {
                comments = { italic = true },
                keywords = { bold = true },
                functions = { bold = true },
                variables = {},

                bufferline = {
                    current = {},
                    modified = { italic = true },
                }
            }
        })
        vim.cmd.colorscheme("nord")
    end
}
