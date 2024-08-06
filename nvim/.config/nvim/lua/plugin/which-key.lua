return {
    'folke/which-key.nvim',
    event = { 'CursorHold', 'CursorHoldI' },
    dependencies = {
        'nvim-tree/nvim-web-devicons' ,
        { 'echasnovski/mini.nvim', version = false },
    },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require('which-key')
        wk.setup({
            keys = {
                scroll_down = '<c-j>',
                scroll_up = '<c-k>',
            },
            layout = {
                spacing = 1,
            }
        })
        wk.add({
            { "<leader>c", group = "comment" },
            { "<leader>f", group = "telescope" },
            { "<leader>g", group = "git" },
        });
    end,
}
