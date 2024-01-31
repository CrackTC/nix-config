local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local servers = {
    "cssls",
    "denols",
    "eslint",
    "gopls",
    "hls",
    "html",
    "jsonls",
    "nil_ls",
    "phpactor",
    "vimls",
    "yamlls",
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end

lspconfig.clangd.setup {
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
    }
}

lspconfig.csharp_ls.setup {
    capabilities = capabilities,
    handlers = {
        ["textDocument/definition"] = require("csharpls_extended").handler,
        ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
    }
}

vim.g.markdown_fenced_languages = {
    "ts=typescript",
}

lspconfig.lua_ls.setup {
    capabilities = capabilities,
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    workspace = {
                        checkThirdParty = false,
                        library = { vim.env.VIMRUNTIME }
                    }
                }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded",
        title = "RTFM"
    }
)

vim.diagnostic.config {
    underline = true,
    virtual_text = false,
    update_in_insert = true,
    float = {
        border = "rounded",
        header = false,
        title = "Oops"
    },
}

local ns = vim.api.nvim_create_namespace("CurlineDiag")
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = args.buf,
            callback = function()
                pcall(vim.api.nvim_buf_clear_namespace, args.buf, ns, 0, -1)
                local hi = { "Error", "Warn", "Info", "Hint" }
                local curline = vim.api.nvim_win_get_cursor(0)[1]
                local diagnostics = vim.diagnostic.get(args.buf, { lnum = curline - 1 })
                local virt_texts = {}
                for _, diag in ipairs(diagnostics) do
                    virt_texts[#virt_texts + 1] = {
                        string.format(" <- %s", diag.message),
                        "DiagnosticVirtualText" .. hi[diag.severity]
                    }
                end
                vim.api.nvim_buf_set_extmark(args.buf, ns, curline - 1, 0, {
                    virt_text = virt_texts,
                    hl_mode = "combine"
                })
            end
        })
    end
})

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "󱐋", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "󰋽", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })


vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float(0, {
            scope = "cursor",
            focusable = false
        })
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                callback = vim.lsp.codelens.refresh,
                buffer = bufnr
            })
        end
    end
})
