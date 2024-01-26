return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        local maps = {
            ["Find Under"] = "<C-k>",
            ["Find Subword Under"] = "<C-k>"
        }
        vim.g.VM_default_mappings = 0
        vim.g.VM_maps = maps
    end
}
