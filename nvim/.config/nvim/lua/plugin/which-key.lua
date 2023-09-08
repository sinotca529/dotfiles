return {
    'folke/which-key.nvim',
    event = { 'CursorHold', 'CursorHoldI' },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require('which-key')
        wk.setup({
            popup_mappings = {
                scroll_down = '<c-j>',
                scroll_up = '<c-k>',
            },
            window = {
                border = 'double',
                margin = { 0, 0, 0, 0 },
                padding = { 0, 0, 0, 0 },
            },
            layout = {
                spacing = 1,
            }
        })
        wk.register({
            ['<leader>g'] = {
                name = 'git',
                u = 'unstage hunk',
                h = 'show hunk',
                b = 'blame',
                d = 'diff',
                r = 'restore hunk'
            },
            ['<leader>f'] = {
                name = 'fzf',
                f = 'file',
                g = 'grep',
                b = 'buf',
                h = 'help tags',
            },
            ['<leader>c'] = {
                name = 'comment',
            }
        })
    end,
}
