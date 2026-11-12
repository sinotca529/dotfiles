-- djot: nvim-treesitter's registry pins a GitHub revision of tree-sitter-djot
-- that SIGSEGVs (push_block() in the external scanner) on real-world .dj
-- files. Upstream moved to Codeberg and fixed it there, but Codeberg's
-- archive layout doesn't match what nvim-treesitter's installer expects, so
-- `:TSInstall djot` / `:TSUpdate` can't fetch the fix. Build it ourselves
-- from Codeberg and drop it in place; skipped once the pinned rev is already
-- installed, so this only does work the first time (or after a rev bump).
local DJOT_REV = 'ed551f3fdc504a04b1b84c78886d8bd8f244331d' -- codeberg tree-sitter-djot v2.1.0+, fixes the crash
local function ensure_djot_parser()
    local parser_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'parser')
    local parser_path = vim.fs.joinpath(parser_dir, 'djot.so')
    local rev_marker = vim.fs.joinpath(parser_dir, '.djot-codeberg-rev')

    local rev_file = io.open(rev_marker, 'r')
    if rev_file then
        local installed_rev = rev_file:read('l')
        rev_file:close()
        if installed_rev == DJOT_REV and vim.uv.fs_stat(parser_path) then
            return
        end
    end

    if vim.fn.executable('git') == 0 or vim.fn.executable('tree-sitter') == 0 then
        vim.notify('djot parser: need `git` and `tree-sitter` CLI to build the Codeberg fix', vim.log.levels.WARN)
        return
    end

    vim.notify('Building djot treesitter parser from Codeberg (GitHub-pinned build SIGSEGVs)...', vim.log.levels.INFO)

    local tmp = vim.fn.tempname()
    local function run(cmd, cwd)
        local result = vim.system(cmd, { cwd = cwd, text = true }):wait()
        if result.code ~= 0 then
            vim.notify(
                string.format('djot parser build failed (%s): %s', cmd[1], result.stderr or ''),
                vim.log.levels.ERROR
            )
            return false
        end
        return true
    end

    local ok = run({ 'git', 'clone', '--quiet', 'https://codeberg.org/treeman/tree-sitter-djot', tmp })
        and run({ 'git', 'checkout', '--quiet', DJOT_REV }, tmp)
        and run({ 'tree-sitter', 'build', '-o', 'parser.so' }, tmp)
    if ok then
        vim.fn.mkdir(parser_dir, 'p')
        vim.uv.fs_copyfile(vim.fs.joinpath(tmp, 'parser.so'), parser_path)

        -- reuse nvim-treesitter's own bundled djot queries (highlights/folds/etc.)
        local query_src = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy', 'nvim-treesitter', 'runtime', 'queries', 'djot')
        local query_dst = vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'queries', 'djot')
        if vim.uv.fs_stat(query_src) and not vim.uv.fs_stat(query_dst) then
            vim.fn.mkdir(vim.fs.dirname(query_dst), 'p')
            vim.uv.fs_symlink(query_src, query_dst, { dir = true })
        end

        local out = io.open(rev_marker, 'w')
        if out then
            out:write(DJOT_REV)
            out:close()
        end
        vim.notify('djot treesitter parser built successfully', vim.log.levels.INFO)
    end

    vim.fn.delete(tmp, 'rf')
end

-- No whole-document djot formatter here on purpose: the only implementation
-- (@djot/djot's `-t djot`) is a parse-to-AST-and-rerender canonicalizer, not
-- a style-preserving formatter -- it strips table column padding with no way
-- to keep it, and escapes any `{...}` that isn't grammatically attached as
-- an attribute (e.g. `{=html}` after a space becomes `\{=html\}`) with no
-- flag to disable it either. Tried it, it corrupts real documents; removed.
--
-- Tables only, using the same formatter as markdown's `<leader>lf`
-- (`prettier --parser markdown`, see conform.lua): djot's pipe-table
-- syntax is the same as GFM's, and prettier's markdown table formatter
-- aligns columns well. Slice out each contiguous run of `|...|` lines,
-- format only that fragment, and splice it back -- everything outside a
-- table (including brittle bits like `{=html}`) is never touched.
local function is_table_row(line)
    return line:match('^%s*|.*|%s*$') ~= nil
end

local function format_djot_tables()
    if vim.fn.executable('prettier') == 0 then
        vim.notify('djot table format: `prettier` not found on $PATH', vim.log.levels.WARN)
        return
    end

    local i = 1
    while true do
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        if i > #lines then
            break
        end
        if not is_table_row(lines[i]) then
            i = i + 1
        else
            local j = i
            while j <= #lines and is_table_row(lines[j]) do
                j = j + 1
            end

            local block = {}
            for k = i, j - 1 do
                table.insert(block, lines[k])
            end
            local tmp = vim.fn.tempname() .. '.md'
            vim.fn.writefile(block, tmp)
            local result = vim.system({ 'prettier', '--parser', 'markdown', tmp }, { text = true }):wait()
            vim.fn.delete(tmp)

            if result.code ~= 0 then
                vim.notify('djot table format failed: ' .. (result.stderr or ''), vim.log.levels.ERROR)
                i = j
            else
                local formatted = vim.split((result.stdout:gsub('\n$', '')), '\n')
                vim.api.nvim_buf_set_lines(0, i - 1, j - 1, false, formatted)
                i = i + #formatted
            end
        end
    end
end

return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').setup()
        require('nvim-treesitter').install({
            'c', 'cpp', 'llvm', 'rust',
            'lua', 'python',
            'markdown', 'markdown_inline',
            'latex',
        })
        ensure_djot_parser()

        -- main branch no longer auto-starts highlighting: https://neovim.io/doc/user/treesitter.html
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'c', 'cpp', 'llvm', 'rust', 'lua', 'python', 'markdown', 'tex', 'djot' },
            callback = function(args)
                pcall(vim.treesitter.start)
                if args.match == 'djot' then
                    -- buffer-local, so it overrides the global conform <leader>lf for djot
                    vim.keymap.set('n', '<leader>lf', format_djot_tables, { buffer = args.buf, silent = true })
                end
            end,
        })

        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
}
