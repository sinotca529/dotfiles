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
                border = 'single',
                margin = { 0, 0, 0, 0 },
                padding = { 0, 0, 0, 0 },
            },
            layout = {
                spacing = 1,
            }
        })
        wk.register({
            ['<leader>g'] = { name = 'git' },
            ['<leader>f'] = { name = 'telescope' },
            ['<leader>c'] = { name = 'comment' }
        })
    end,
}
