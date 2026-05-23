local extensions = {
    "bash",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "fish",
    "gitignore",
    "go",
    "haskell",
    "html",
    "hurl",
    "llvm",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nix",
    "python",
    "query",
    "scheme",
    "toml",
    "vim",
    "vimdoc",
    "xml",
    "yaml"
}

local function setup_plugin()
    local ts = require('nvim-treesitter')

    -- State tracking for async parser loading
    local parsers_loaded = {}
    local parsers_pending = {}
    local parsers_failed = {}

    local ns = vim.api.nvim_create_namespace("treesitter.async")

    -- Helper to start highlighting and indentation
    local function start(buf, lang)
        local ok = pcall(vim.treesitter.start, buf, lang)
        if ok then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
        return ok
    end

    -- Install core parsers after lazy.nvim finishes loading all plugins
    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        once = true,
        callback = function () ts.install(extensions, { max_jobs = 8 }) end
    })

    -- Decoration provider for async parser loading
    vim.api.nvim_set_decoration_provider(ns, {
        on_start = vim.schedule_wrap(function ()
            if #parsers_pending == 0 then
                return false
            end
            for _, data in ipairs(parsers_pending) do
                if vim.api.nvim_buf_is_valid(data.buf) then
                    if start(data.buf, data.lang) then
                        parsers_loaded[data.lang] = true
                    else
                        parsers_failed[data.lang] = true
                    end
                end
            end
            parsers_pending = {}
        end)
    })

    local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

    local ignore_filetypes = {
        "checkhealth",
        "lazy",
        "mason",
        "yazi",
        "undotree"
    }

    -- Auto-install parsers and enable highlighting on FileType
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        desc = "Enable treesitter highlighting and indentation (non-blocking)",
        callback = function (event)
            if vim.tbl_contains(ignore_filetypes, event.match) then return end

            local lang = vim.treesitter.language.get_lang(event.match) or event.match
            local buf = event.buf

            if parsers_failed[lang] then
                return
            end

            if parsers_loaded[lang] then
                -- Parser already loaded, start immediately (fast path)
                start(buf, lang)
            else
                -- Queue for async loading
                table.insert(parsers_pending, { buf = buf, lang = lang })
            end

            -- Auto-install missing parsers (async, no-op if already installed)
            ts.install { lang }
        end
    })
end

local function setup_variables()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()";
    vim.opt.foldenable = false -- Disable folding at startup.
end

local function setup_highlights()
    -- mainly for markdown
    vim.api.nvim_set_hl(0, "@text.emphasis", { italic = true, fg = "#88c0d0" })
    vim.api.nvim_set_hl(0, "@text.strong", { bold = true, fg = "#88c0d0" })
    vim.api.nvim_set_hl(0, "@text.strike", { strikethrough = true, fg = "#88c0d0" })
    vim.api.nvim_set_hl(0, "@text.literal", { link = "@punctuation.delimiter" })
    vim.api.nvim_set_hl(0, "@text.uri", { underline = true, fg = "#a3be8c" })
end

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        setup_variables()
        setup_plugin()
        setup_highlights()
    end
}
