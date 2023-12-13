local M = {}

local function setup_plugin()
    require("notify").setup({
        stages = "fade",
        render = "compact"
    })
end

local function setup_variables()
    vim.notify = require("notify")
end

-- local function setup_coc_diagnostic_notification()
--     local notify = require("notify")
--     local coc_diagnostic_record = {}
--
--     local function reset_coc_diagnostic_record(_)
--         coc_diagnostic_record = {}
--     end
--
--     local function coc_diagnostic_do_notify(msg, level)
--         local notify_opts = {
--             title = "LSP Diagnostics",
--             timeout = 500,
--             on_close = reset_coc_diagnostic_record
--         }
--         if coc_diagnostic_record ~= {} then
--             notify_opts["replace"] = coc_diagnostic_record.id
--         end
--         coc_diagnostic_record = notify(msg, level, notify_opts)
--     end
--
--     local function coc_diagnostic_notify()
--         local info = vim.b.coc_diagnostic_info
--         if info == nil then
--             return ""
--         end
--
--         local messages = {}
--         local level = "info"
--
--         if info.warning > 0 then
--             level = "warn"
--         end
--
--         if info.error > 0 then
--             level = "error"
--         end
--
--         if info.error > 0 then
--             messages[#messages + 1] = "󰃤 Errors: " .. info.error
--         end
--
--         if info.warning > 0 then
--             messages[#messages + 1] = "󱐋 Warnings: " .. info.warning
--         end
--
--         if info.information > 0 then
--             messages[#messages + 1] = "󰋼 Infos: " .. info.information
--         end
--
--         if info.hint > 0 then
--             messages[#messages + 1] = "󰌵 Hints: " .. info.hint
--         end
--
--         local message = table.concat(messages, "\n")
--
--         if vim.trim(message) == "" then
--             message = " All OK"
--         end
--
--         coc_diagnostic_do_notify(message, level)
--     end
--
--     vim.api.nvim_create_autocmd("User", {
--         pattern = "CocDiagnosticChange",
--         callback = coc_diagnostic_notify
--     })
-- end

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

local function setup_coc_notification()
    setup_coc_status_notification()
    -- setup_coc_diagnostic_notification()
end

local function show_welcome()
    require("notify").notify("今日もいい天気だよ～", "info", {
        timeout = 500
    })
end

function M.config()
    setup_plugin()
    setup_variables()
    setup_coc_notification()

    show_welcome()
end

return M
