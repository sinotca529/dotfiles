return {
    'kylechui/nvim-surround',
    event = 'VeryLazy', -- ys/cs/ds are normal-mode maps
    config = function()
        require('nvim-surround').setup({})
    end
}
