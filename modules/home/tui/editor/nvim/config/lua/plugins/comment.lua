return {
    "numToStr/Comment.nvim",
    config = function()
        require('Comment').setup({
            toggler = {
                line = "dcc",
                block = "dbc"
            },
            opleader = {
                line = "dc",
                block = "db"
            },
            mappings = {
                basic = true,
                extra = false
            }
        })
    end
}
