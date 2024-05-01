-- [[util functions]] --

local M = {}

-- [maps] --

local map = vim.keymap.set

function M.remap(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.remap = true

    if lhs ~= rhs then
        map(mode, lhs, rhs, opts)
    end
end

function M.noremap(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = true
    if mode == "" then
        mode = { "n", "x", "o" }
    end
    map(mode, lhs, rhs, opts)
end

function M.nnoremap(lhs, rhs, opts)
    M.noremap('n', lhs, rhs, opts)
end

function M.inoremap(lhs, rhs, opts)
    M.noremap('i', lhs, rhs, opts)
end

function M.vnoremap(lhs, rhs, opts)
    M.noremap('v', lhs, rhs, opts)
end

function M.snoremap(lhs, rhs, opts)
    M.noremap('s', lhs, rhs, opts)
end

function M.cnoremap(lhs, rhs, opts)
    M.noremap('c', lhs, rhs, opts)
end

function M.tnoremap(lhs, rhs, opts)
    M.noremap('t', lhs, rhs, opts)
end

function M.imap(lhs, rhs, opts)
    M.remap('i', lhs, rhs, opts)
end

function M.nmap(lhs, rhs, opts)
    M.remap('n', lhs, rhs, opts)
end

function M.xmap(lhs, rhs, opts)
    M.remap('x', lhs, rhs, opts)
end

function M.xnoremap(lhs, rhs, opts)
    M.noremap('x', lhs, rhs, opts)
end

function M.omap(lhs, rhs, opts)
    M.remap('o', lhs, rhs, opts)
end

function M.onoremap(lhs, rhs, opts)
    M.noremap('o', lhs, rhs, opts)
end

function M.buffered_remap(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = true
    M.remap(mode, lhs, rhs, opts)
end

function M.buffered_nmap(lhs, rhs, opts)
    M.buffered_remap('n', lhs, rhs, opts)
end

function M.buffered_imap(lhs, rhs, opts)
    M.buffered_remap('i', lhs, rhs, opts)
end

function M.buffered_vmap(lhs, rhs, opts)
    M.buffered_remap('v', lhs, rhs, opts)
end

function M.buffered_noremap(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = true
    M.noremap(mode, lhs, rhs, opts)
end

function M.buffered_inoremap(lhs, rhs, opts)
    M.buffered_noremap('i', lhs, rhs, opts)
end

function M.buffered_nnoremap(lhs, rhs, opts)
    M.buffered_noremap('n', lhs, rhs, opts)
end

-- [filetype] --

function M.on_filetype(filetype, fn)
    vim.api.nvim_create_autocmd({ "Filetype" }, {
        pattern = filetype,
        callback = fn
    })
end

-- [compile and run] --

local function split_run(command)
    vim.opt.splitbelow = true
    vim.cmd('split')
    vim.cmd('resize -5')
    vim.cmd('terminal ' .. command)
end

local function join_path(paths)
    table.remove(paths)
    table.sort(paths, function(a, b) return #a < #b end)
    for i, path in ipairs(paths) do
        paths[i] = vim.fn.fnamemodify(path, ':p:h:t')
    end
    print(vim.inspect(paths))
    return table.concat(paths, '/')
end

local function cmake_run()
    local cmake_find_result = vim.fs.find({ 'CMakeLists.txt' },
        { upward = true, limit = math.huge, path = vim.fn.expand('%:p:h') });
    local root = vim.fs.dirname(cmake_find_result[#cmake_find_result])
    local cmake_project_path = join_path(cmake_find_result)

    if root then
        split_run('cmake -S ' ..
            root ..
            ' -B ' ..
            root ..
            '/build && cmake --build ' ..
            root ..
            '/build && ' ..
            root .. '/build/' .. cmake_project_path .. '/' .. vim.fn.fnamemodify(cmake_project_path, ':t'))
        return true
    end

    return false
end


function M.compile_run()
    vim.cmd('write')

    if cmake_run() then
        return
    elseif vim.fn.filereadable('Makefile') == 1 then
        split_run('make clean build run')
    elseif vim.fn.filereadable(vim.fn.expand('%:p:h') .. '/Makefile') == 1 then
        split_run('make clean build run -C ' .. vim.fn.expand('%:p:h'))
    elseif vim.bo.filetype == 'c' then
        vim.cmd('exec "!clang -Wall -g -lm -o %< %"')
        split_run('time ./%<')
    elseif vim.bo.filetype == 'cpp' then
        vim.cmd('exec "!clang++ -O0 -std=c++11 -Wall -g -o %< %"')
        split_run('time ./%<')
    elseif vim.bo.filetype == 'java' then
        vim.cmd('exec "!javac %"')
        split_run('time java %<')
    elseif vim.bo.filetype == 'sh' then
        split_run('time bash %')
    elseif vim.bo.filetype == 'lisp' then
        split_run('sbcl --script %')
    elseif vim.bo.filetype == 'python' then
        split_run('python3 %')
    elseif vim.bo.filetype == 'html' then
        vim.cmd('silent! execute "!chromium % &"')
    elseif vim.bo.filetype == 'markdown' then
        vim.cmd('MarkdownPreview')
    elseif vim.bo.filetype == 'javascript' then
        split_run('export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .')
    elseif vim.bo.filetype == 'go' then
        if vim.fn.filereadable('go.mod') == 1 then
            split_run('go run .')
        else
            split_run('go mod init && go run .')
        end
    elseif vim.bo.filetype == 'cs' then
        split_run('dotnet run')
    elseif vim.bo.filetype == 'php' then
        split_run('php %')
    elseif vim.bo.filetype == 'scheme' then
        split_run('mit-scheme < "%"')
    elseif vim.bo.filetype == 'haskell' then
        split_run('ghc --make -no-keep-hi-files -no-keep-o-files -o %< % && ./%<')
    end
end

-- [system interaction] --
function M.ensure_dir_exists(dir)
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, 'p')
    end
end

local bufname = "SingleTerminal"
-- Define term position and size
local splitconfig = "bot 20 split "
local bufid = -1
local terminal_opened_win_id = -1

local function show_term(wind_id)
    terminal_opened_win_id = wind_id
    vim.cmd(splitconfig .. "| buffer " .. bufname)
    vim.cmd("startinsert")
end

local function new_term(wind_id)
    terminal_opened_win_id = wind_id
    vim.cmd(splitconfig .. "| term")
    vim.cmd("file " .. bufname)
    vim.wo.relativenumber = false
    vim.o.number = false
    vim.bo.buflisted = false
    vim.wo.foldcolumn = '0'
    bufid = vim.api.nvim_buf_get_number(0)
    vim.cmd("startinsert")
end

--- Open or create terminal
function M.open_term()
    local buf_exist = vim.api.nvim_buf_is_valid(bufid)
    local current_wind_id = vim.api.nvim_get_current_win()
    if buf_exist then
        local bufinfo = vim.fn.getbufinfo(bufid)[1]
        if bufinfo.hidden == 1 then
            show_term(current_wind_id)
        else
            vim.fn.win_gotoid(bufinfo.windows[1])
            vim.cmd(":hide")
            if current_wind_id ~= terminal_opened_win_id and current_wind_id ~= bufinfo.windows[1] then
                vim.fn.win_gotoid(current_wind_id)
                show_term(current_wind_id)
            end
        end
    else
        new_term(current_wind_id)
    end
end

return M
