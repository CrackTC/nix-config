local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local servers = {
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
    "phpactor",
    "pyright",
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

local original_show_message = vim.lsp.handlers["window/showMessage"]

vim.lsp.handlers["window/showMessage"] = function (err, result, context, config)
  local client = vim.lsp.get_client_by_id(context.client_id)

  local message_type = context and context.message_type
  if client and client.name == "csharp_ls" then
    if message_type ~= 1 then
      -- Suppress non-error messages
      return
    end
  end

  return original_show_message(err, result, context, config)
end

lspconfig.nil_ls.setup {
    capabilities = capabilities,
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixfmt" }
            },
            nix = {
                maxMemoryMB = 32768,
                flake = {
                    autoArchive = true,
                    autoEvalInputs = true,
                    nixpkgsInputName = "nixpkgs"
                }
            }
        }
    }
}

require("csharpls_extended").buf_read_cmd_bind()

vim.g.markdown_fenced_languages = {
    "ts=typescript",
}

lspconfig.lua_ls.setup {
    capabilities = capabilities,
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
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ title = "RTFM" })

vim.diagnostic.config {
    underline = true,
    virtual_text = false,
    update_in_insert = true,
    float = {
        border = "rounded",
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
                callback = vim.lsp.codelens.refresh,
                buffer = bufnr
            })
        end
    end
})

vim.lsp.set_log_level(vim.log.levels.OFF)
