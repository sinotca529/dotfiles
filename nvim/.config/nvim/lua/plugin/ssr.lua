return {
    'cshuaimin/ssr.nvim',
    keys = {
        { '<leader>sr', mode = 'n' },
        { '<leader>sr', mode = 'x' },
    },
    config = function()
        require('ssr').setup({
            border = 'rounded'
        })
        vim.keymap.set(
            {'n', 'x'},
            '<leader>sr',
            function() require('ssr').open() end
        )
    end,
}
