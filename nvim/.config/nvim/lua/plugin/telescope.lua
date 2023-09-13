return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = '0.1.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
        local b = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', b.find_files, { desc = 'find file' })
        vim.keymap.set('n', '<leader>fg', b.live_grep, { desc = 'live grep' })
        vim.keymap.set('n', '<leader>fb', b.buffers, { desc = 'buffers' })
        vim.keymap.set('n', '<leader>fh', b.help_tags, { desc = 'help tags' })
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
