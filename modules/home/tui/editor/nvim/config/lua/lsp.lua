local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.config("clangd", { cmd = { "clangd", "--offset-encoding=utf-16", } })
vim.lsp.config("csharp_ls", {
    handlers = {
        ["textDocument/definition"] = require("csharpls_extended").handler,
        ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
    },
    cmd = function(dispatchers, config)
        return vim.lsp.rpc.start({ "csharp-ls", "--features", "metadata-uris" }, dispatchers, {
            cwd = config.cmd_cwd or config.root_dir,
            env = config.cmd_env,
            detached = config.detached,
        })
    end
})

require("csharpls_extended").buf_read_cmd_bind()

vim.lsp.config("nil_ls", {
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixfmt" }
            },
            nix = {
                maxMemoryMB = 32768,
                flake = {
                    autoArchive = false,
                    autoEvalInputs = true,
                    nixpkgsInputName = "nixpkgs"
                }
            }
        }
    }
})

vim.g.markdown_fenced_languages = {
    "ts=typescript",
}

vim.lsp.config("lua_ls", {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
            return
        end

        local library = vim.api.nvim_get_runtime_file("", true)
        table.insert(library, "${3rd}/luv/library")

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
            runtime = { version = 'LuaJIT' },
            workspace = {
                checkThirdParty = false,
                library = library
            }
        })
    end
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ title = "RTFM" })

vim.diagnostic.config {
    underline = true,
    virtual_text = false,
    update_in_insert = true,
    jump = {
        on_jump = function(diagnostic, bufnr)
            local title
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                title = "Error"
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                title = "Warning"
            elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                title = "Info"
            elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                title = "Hint"
            end
            vim.diagnostic.open_float({
                bufnr = bufnr,
                scope = "cursor",
                focus = false,
                title = title,
                border = "rounded"
            })
        end
    }
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

vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "󱐋",
            [vim.diagnostic.severity.INFO] = "󰋽",
            [vim.diagnostic.severity.HINT] = ""
        }
    }
}

vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float(nil, {
            scope = "cursor",
            focusable = false
        })
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client == nil then return end
        if client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
                callback = function(arg) vim.lsp.codelens.enable(true, { bufnr = arg.buf }) end,
                buffer = bufnr
            })
        end
    end
})

vim.lsp.enable({
    "clangd",
    "cmake",
    "csharp_ls",
    "cssls",
    "denols",
    "eslint",
    "gopls",
    "hls",
    "html",
    "jdtls",
    "jsonls",
    "lua_ls",
    "nil_ls",
    "phpactor",
    "pyright",
    "vimls",
    "yamlls",
})

vim.lsp.log.set_level(vim.log.levels.OFF)
