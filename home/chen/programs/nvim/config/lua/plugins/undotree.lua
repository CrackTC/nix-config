return {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    init = function()
        local utils = require("utils")
        utils.nnoremap("<leader>n", ":UndotreeToggle<CR>")

        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_ShortIndicators    = 1
        vim.g.undotree_WindowLayout       = 2
        vim.g.undotree_DiffpanelHeight    = 8
        vim.g.undotree_SplitWidth         = 24
        vim.g.undotree_DiffAutoOpen       = 1

        vim.g.undotree_TreeNodeShape      = ""
        vim.g.undotree_TreeVertShape      = "│"
        vim.g.undotree_TreeSplitShape     = "╯"
        vim.g.undotree_TreeReturnShape    = "╰"

        vim.g.undotree_HighlightSyntaxAdd = "GitSignsAdd"
        vim.g.undotree_HighlightSyntaxChange = "GitSignsChange"
        vim.g.undotree_HighlightSyntaxDel = "GitSignsDelete"

        vim.g.undotree_HelpLine = 0

        vim.g.undotree_CustomMap = function ()
            utils.buffered_nmap("N", "J")
            utils.buffered_nmap("E", "K")
            utils.buffered_nmap("D", "G")
        end
    end
}
