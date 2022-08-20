return {
    use_arg_list = {
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.0',
            requires = {{'nvim-lua/plenary.nvim'}}
        }
    },
    init = function()
        vim.keymap.set('n', 'ff', '<cmd>Telescope find_files<CR>')
    end
}

