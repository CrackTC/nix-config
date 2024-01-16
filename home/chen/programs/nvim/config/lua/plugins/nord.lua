local M = {}

function M.config()
    require("nord").setup({
        transparent = true,
        terminal_colors = true,
        diff = { mode = "bg" },
        borders = true,
        errors = { mode = "bg" },
        search = { theme = "vim" },

        style = {
            comments = { italic = true },
            keywords = {},
            functions = {},
            variables = {},

            bufferline = {
                current = {},
                modified = { italic = true },
            }
        }
    })
    vim.cmd.colorscheme("nord")
end

return M
