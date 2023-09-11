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

-- [higroup] --
function M.print_higroup()
    local synID = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
    local name = vim.fn.synIDattr(synID, 'name')
    local transName = vim.fn.synIDattr(vim.fn.synIDtrans(synID), 'name')
    print(name .. " -> " .. transName)
end

-- [compile and run] --

local function split_run(command)
    vim.opt.splitbelow = true
    vim.cmd('split')
    vim.cmd('resize -5')
    vim.cmd('terminal ' .. command)
end

function M.compile_run()
    vim.cmd('write')

    if vim.fn.filereadable('Makefile') == 1 then
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
    end
end

-- [system interaction] --
function M.ensure_dir_exists(dir)
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, 'p')
    end
end

return M
