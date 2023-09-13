return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = '0.1.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
        vim.keymap.set('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', {})
        vim.keymap.set('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', {})
        vim.keymap.set('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', {})
        vim.keymap.set('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', {})
    end,
    config = function()
        local ac = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = ac.move_selection_previous,
                        ['<C-j>'] = ac.move_selection_next,
                    },
                },
            },
            file_ignore_patterns = {
                '*.a',
                '*.o',
                '*.so',
                '*.out',
            },
        })
    end
}
