return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
        require("lsp_signature").on_attach {
            bind = true,
            floating_window = true,
            hint_enable = false,
            handler_opts = {
                border = "rounded"
            },
            extra_trigger_chars = { "(", ",", " " },
            zindex = 10,
        }
    end
}
