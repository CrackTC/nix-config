return {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
        require("hlchunk").setup({
            chunk = {
                enable = true,
                notify = true,
                use_treesitter = true,
                chars = {
                    horizontal_line = "─",
                    vertical_line = "│",
                    left_top = "╭",
                    left_bottom = "╰",
                    right_arrow = ">"
                },
                style = { { fg = "#8fbcbb" } }
            },
            indent = { enable = false },
            line_num = {
                enable = true,
                style = { { fg = "#8fbcbb" } }
            },
            blank = { enable = false }
        })
    end
}
