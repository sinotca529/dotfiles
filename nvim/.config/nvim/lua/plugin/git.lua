local function git_signs()
    return {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signs = {
                    untracked = { text = '┃' }
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end
                    map('n', '<Leader>gu', gs.undo_stage_hunk)
                    map('n', '<Leader>gh', gs.preview_hunk)
                    map('n', '<Leader>gb', function() gs.blame_line{full=true} end)
                    map('n', '<Leader>gd', gs.diffthis)
                    map('n', '<Leader>gr', gs.reset_hunk)
                end,
            })
        end
    }
end

return function(plugins)
    plugins[#plugins+1] = git_signs()
end
