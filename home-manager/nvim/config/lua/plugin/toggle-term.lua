return {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
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
            float_opts = {
                border = 'curved',
                width = function() return math.floor(vim.o.columns * 0.9) end,
                height = function() return math.floor(vim.o.lines * 0.9) end,
            },
        })
    end
}
