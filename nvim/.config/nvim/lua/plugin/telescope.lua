return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
        vim.keymap.set('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', { desc = 'find file' })
        vim.keymap.set('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', { desc = 'live grep' })
        vim.keymap.set('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', { desc = 'buffers' })
        vim.keymap.set('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', { desc = 'help tags' })
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
            pickers = {
                find_files = { follow = true },
            }
        })
    end
}
