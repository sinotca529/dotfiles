return {
    'lewis6991/gitsigns.nvim',
    event = { 'CursorHold', 'CursorHoldI' },
    config = function()
        require('gitsigns').setup({
            signs = {
                untracked = { text = '┃' }
            },
            sign_priority = 100,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                map('n', '<Leader>gs', gs.stage_hunk, { desc = 'stage hunk' })
                map('n', '<Leader>gu', gs.undo_stage_hunk, { desc = 'unstage hunk' })
                map('n', '<Leader>gh', gs.preview_hunk, { desc = 'show hunk' })
                map('n', '<Leader>gb', function() gs.blame_line { full = true } end, { desc = 'blame' })
                map('n', '<Leader>gd', gs.diffthis, { desc = 'diff' })
                map('n', '<Leader>gr', gs.reset_hunk, { desc = 'restore hunk' })
            end,
            -- word_diff = true,
        })
    end
}
