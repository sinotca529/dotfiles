-- Japanese prose checking with textlint for markdown and tex.
-- nvim-lint ships no textlint linter, so it is defined here.
-- Rules come from the project's .textlintrc*; without one textlint reports
-- nothing. tex additionally needs textlint-plugin-latex2e in that project.

local config_files = {
    '.textlintrc', '.textlintrc.json', '.textlintrc.yml', '.textlintrc.yaml', '.textlintrc.js', '.textlintrc.cjs',
}

-- directory holding the nearest .textlintrc (textlint reads its config from cwd)
local function textlint_root(bufnr)
    return vim.fs.root(bufnr, config_files) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
end

-- textlint columns are 1-based UTF-16 offsets; diagnostics want 0-based bytes
local function byte_col(bufnr, lnum, col)
    local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1] or ''
    local ok, byte = pcall(vim.str_byteindex, line, 'utf-16', col - 1, false)
    return ok and byte or col - 1
end

local function parse(output, bufnr)
    local ok, results = pcall(vim.json.decode, output)
    if not ok or type(results) ~= 'table' then
        return {}
    end
    local diagnostics = {}
    for _, result in ipairs(results) do
        for _, m in ipairs(result.messages or {}) do
            local s = m.loc and m.loc.start or { line = m.line, column = m.column }
            local e = m.loc and m.loc['end'] or s
            diagnostics[#diagnostics + 1] = {
                lnum = s.line - 1,
                col = byte_col(bufnr, s.line, s.column),
                end_lnum = e.line - 1,
                end_col = byte_col(bufnr, e.line, e.column),
                severity = m.severity == 2 and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
                message = m.message,
                code = m.ruleId,
                source = 'textlint',
            }
        end
    end
    return diagnostics
end

local function lint()
    require('lint').try_lint(nil, { cwd = textlint_root(0) })
end

return {
    'mfussenegger/nvim-lint',
    ft = { 'markdown', 'tex' },
    config = function()
        local lint_mod = require('lint')
        lint_mod.linters.textlint = {
            -- prefer the project's own textlint (rules are usually installed next to it)
            cmd = function()
                local root = textlint_root(0)
                local local_bin = vim.fs.joinpath(root, 'node_modules', '.bin', 'textlint')
                return vim.fn.executable(local_bin) == 1 and local_bin or 'textlint'
            end,
            stdin = true,
            args = {
                '--format', 'json', '--stdin',
                '--stdin-filename', function() return vim.api.nvim_buf_get_name(0) end,
            },
            stream = 'stdout',
            ignore_exitcode = true,
            parser = parse,
        }
        lint_mod.linters_by_ft = {
            markdown = { 'textlint' },
            tex = { 'textlint' },
        }
        vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
            group = vim.api.nvim_create_augroup('nvim_lint', {}),
            pattern = { '*.md', '*.markdown', '*.tex' },
            callback = lint,
        })
        -- the buffer that triggered loading (ft = ...) already passed BufReadPost
        lint()
    end,
}
