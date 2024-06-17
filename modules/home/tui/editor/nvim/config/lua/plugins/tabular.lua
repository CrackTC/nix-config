return {
    "godlygeek/tabular",
    cmd = "Tabularize",
    init = function()
        require("utils").xnoremap("A", ":Tabularize /")
    end
}
