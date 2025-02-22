return {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-treesitter/nvim-treesitter',
    },
    event = 'LspAttach',
    config = function()
        local lspsaga = require('lspsaga')
        lspsaga.setup({
            symbol_in_winbar = { enable = false, },
            ui = {
                title = false,
                border = 'rounded',
                code_action = '',
            },
            beacon = {
                enable = false,
            },
            implement = {
                enable = false,
            },
            finder = {
                default = 'typd+def+imp+ref',
                keys = {
                    toggle_or_open = '<CR>',
                },
            },
            diagnostic = {
                max_show_width = 0.6
            },
            floaterm = {
                height = 0.8,
                width = 0.9,
            }
        })

        vim.keymap.set('n', '<C-.>', '<cmd>Lspsaga code_action<CR>')
        vim.keymap.set('n', '<leader>lsf', '<cmd>Lspsaga finder<CR>')
        vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>')
    end,
}
