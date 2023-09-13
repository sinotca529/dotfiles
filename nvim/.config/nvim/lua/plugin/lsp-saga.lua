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
            scrolling = {
                scroll_down = '<C-j>',
                scroll_up = '<C-k>',
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
        })

        -- vim.keymap.set('n', '<space>', '<cmd>Lspsaga hover_doc<CR>')
        vim.keymap.set('n', '<C-.>', '<cmd>Lspsaga code_action<CR>')
        -- vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>')
    end,
}
