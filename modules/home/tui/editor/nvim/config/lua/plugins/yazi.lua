---@type LazySpec
return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>pa",
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        }
    },
    ---@type YaziConfig
    opts = {
        open_for_directories = true
    }
}
