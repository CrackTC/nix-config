local M = {}

local markdown_options = {
    dash_string = "—",
    headline_highlights = {
        "Headline1",
        "Headline2",
        "Headline3",
        "Headline4",
        "Headline5",
        "Headline6"
    }
}

local function setup_plugin()
    require("headlines").setup({
        markdown = markdown_options
    })
end

function M.config()
    setup_plugin()
end

return M
