local function setup_plugin()
    require("notify").setup({
        stages = "fade",
        render = "default"
    })
end

local function setup_variables()
    vim.notify = require("notify")
end

local function show_welcome()
    -- require("notify").notify("今日もいい天気だよ～", "info", { timeout = 500 })
end

return {
    "rcarriga/nvim-notify",
    config = function()
        setup_plugin()
        setup_variables()
        show_welcome()
    end
}
