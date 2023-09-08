return {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    version = 'v2.*',
    init = function()
        vim.keymap.set('n', '<C-Space>', '<Cmd>ToggleTerm<CR>', {})
        vim.keymap.set('i', '<C-Space>', '<Cmd>ToggleTerm<CR>', {})
    end,
    config = function()
        require('toggleterm').setup({
            open_mapping = [[<C-Space>]],
            insert_mappings = true,
            close_on_exit = true,
            direction = 'float',
        })
    end
}
