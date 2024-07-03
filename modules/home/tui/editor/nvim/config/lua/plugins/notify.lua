local function setup_plugin()
    require("notify").setup({
        stages = "fade",
        render = "default"
    })
end

local function setup_variables()
    vim.notify = require("notify")
end

local function setup_coc_status_notification()
    local notify = require("notify")

    local coc_status_record = {}

    local function reset_coc_status_record(_)
        coc_status_record = {}
    end

    local function coc_status_do_notify(msg, level)
        local notify_opts = {
            title = "LSP Status",
            timeout = 500,
            hide_from_history = true,
            on_close = reset_coc_status_record
        }
        if coc_status_record ~= {} then
            notify_opts["replace"] = coc_status_record.id
        end
        coc_status_record = notify(msg, level, notify_opts)
    end


    local function coc_status_notify()
        local status = vim.g.coc_status
        local level = "info"
        if status == nil then
            return ""
        end
        coc_status_do_notify(status, level)
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "CocStatusChange",
        callback = coc_status_notify
    })
end


local function show_welcome()
    -- require("notify").notify("今日もいい天気だよ～", "info", { timeout = 500 })
end

return {
    "rcarriga/nvim-notify",
    config = function()
        setup_plugin()
        setup_variables()
        setup_coc_status_notification()

        show_welcome()
    end
}
